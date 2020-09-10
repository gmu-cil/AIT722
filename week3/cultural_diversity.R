library(dplyr)
library(stringr)
library(ggmap)
library(geosphere)
library(readr)
library(jsonlite)
library(tidytext)
library(SnowballC)
library(tm)
library(reshape2)
library(gtools)
library(lsa)
library(text2vec)
library(LDAvis)
library(diverse)

setwd("~/git/AIT722/week3/") 

events <- read_delim("data/Meetup_Washington_DC_samples.csv", delim = ",",col_names = T)

# We're using event title and description for quantifying cultural diversity.
# to do so, it is necessary to process the text data using NLP packages. 

# function 1: getting name tokens after after preprocessing the text
get_name_tokens <- function (event_df){
  tidy_events <- event_df %>% dplyr::select(event_id, name)
  tidy_events <- tidy_events[,c("event_id", "name")]
  tidy_events <- tidy_events %>% unnest_tokens("word", name)
  
  #removing numbers
  if (nrow(tidy_events[str_detect(tidy_events$word, "\\b\\d+\\b"),]) !=0){
    tidy_events <- tidy_events[-grep("\\b\\d+\\b", tidy_events$word),]  
  } 
  
  # removing whitespaces
  tidy_events$word <- gsub("\\s+","",tidy_events$word)

  # Stemming
  tidy_events <- tidy_events %>% mutate_at("word", funs(wordStem((.), language="en")))
  
  tidy_events
}

# function 2: getting description tokens after preprocessing the text
get_description_tokens <- function (event_df){
  data("stop_words")
  
  tidy_events <- event_df %>% dplyr::select(event_id, description)
  tidy_events <- tidy_events[,c("event_id", "description")]
  tidy_events <- tidy_events %>% unnest_tokens("word", description)
  
  #Removing stop words
  tidy_events <- tidy_events %>% anti_join(stop_words, by=c("word"))
  
  #removing numbers
  if (nrow(tidy_events[str_detect(tidy_events$word, "\\b\\d+\\b"),]) !=0){
    tidy_events<-tidy_events[-grep("\\b\\d+\\b", tidy_events$word),]
  }
  
  # removing whitespaces
  tidy_events$word <- gsub("\\s+","",tidy_events$word)
  
  # Stemming
  tidy_events <- tidy_events %>% mutate_at("word", funs(wordStem((.), language="en")))
  
  tidy_events
}

# function 3: returning title and description of events as "bag of words"
get_bag_of_words <- function(events){
  bags <- get_name_tokens(events)
  bags2 <- get_description_tokens(events)
  bags <- bags %>% group_by(event_id) %>% summarise(paste(word, collapse = " "))
  bags2 <- bags2 %>% group_by(event_id) %>% summarise(paste(word, collapse = " "))
  colnames(bags) <- c("event_id", "name")
  colnames(bags2) <- c("event_id", "description")
  bags <- bags %>% left_join(bags2, by=c("event_id"))
  bags
}

# function 4: function to calculate topic score distribution in the city
# highest topic: +2, second-highest topic: +1, third: +0...
# the argument is matrix
calculate_topic_scores <- function(topic_dist){
  columns=c("entity", "category", "value")
  score_df <- data.frame(matrix(ncol=length(columns), nrow=k))
  colnames(score_df) <- columns
  score_df$entity <- 1
  score_df$category <- 1:k
  score_df$value <- 0
  
  for (i in 1:nrow(topic_dist)){
    highest_topic <- which.max(topic_dist[i,])
    second_topic <- which.max(topic_dist[i,][topic_dist[i,]!=max(topic_dist[i,])])
    
    # If there's no variation in the topic distribution for the doc, skip it.
    if (max(topic_dist[i,]) == min(topic_dist[i,])){
      next
    } else if (max(topic_dist[i,][topic_dist[i,]!=max(topic_dist[i,])]) == min(topic_dist[i,])){
      score_df$value[score_df$category==highest_topic] <- score_df$value[score_df$category==highest_topic] + 2   
      next
    } else {
      score_df$value[score_df$category==highest_topic] <- score_df$value[score_df$category==highest_topic] + 2   
      score_df$value[score_df$category==second_topic] <- score_df$value[score_df$category==second_topic] + 1  
    }
    
  }
  return (score_df)
}


events <- get_bag_of_words(events)
events$description <- paste(events$name, events$description)
events <- events[,c("event_id", "description")]

# Removing "NA" from training
events$description <- gsub(" NA ", " ", events$description)
events$description <- gsub(" NA", "", events$description)
events$description <- gsub("NA ", "", events$description)

# Tokenizing the event description as "document-term matrix"
it = itoken(events$description, progressbar = TRUE)
v = create_vocabulary(it) %>%
  prune_vocabulary(doc_proportion_max = 0.1, term_count_min = 5)
vectorizer = vocab_vectorizer(v)
dtm = create_dtm(it, vectorizer)

# Topic modeling using LDA: currently we set the number of topics as 10. 
k = 10
a = 0.2
t = 0.07

lda_model = LDA$new(n_topics = k, doc_topic_prior = a, topic_word_prior = t)
doc_topic_distr = lda_model$fit_transform(x = dtm, n_iter = 1000,
                                          convergence_tol = 0.001, n_check_convergence = 25,
                                          progressbar = TRUE)

# Visualizing topic models using the LDAvis package
lda_model$plot()


# cosine distance between topic models
matrix <- as.matrix(lda_model$topic_word_distribution)
sim <- matrix / sqrt(rowSums(matrix * matrix))
sim <- sim %*% t(sim)
cos_dist <- (1 - sim)
colnames(cos_dist) <- 1:ncol(cos_dist)
rownames(cos_dist) <- 1:nrow(cos_dist)

tmp_doc_topic_distr <- lda_model$transform(dtm) 
topic_scores <- calculate_topic_scores(tmp_doc_topic_distr) 

# Calculating cultural diversity based on different entroy measures
rao_stirling <- as.numeric(diversity(topic_scores, type="rao-stirling", dis=cos_dist))
shannon <- as.numeric(diversity(topic_scores, type="entropy"))
hhi <- as.numeric(diversity(topic_scores, type="herfindahl-hirschman"))

rao_stirling
shannon
hhi
