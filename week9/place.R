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

setwd("~/git/AIT722/week9/") 

events <- read_delim("data/Meetup_Washington_DC_samples.csv", delim = ",",col_names = T)

# unique venues
venues <- events[,c("venue_id", "lon", "lat")]
venues <- venues[!duplicated(venues$venue_id),]
venues <- venues[complete.cases(venues),]

# activity-level information: topic modeling
it = itoken(events$description, progressbar = TRUE)
v = create_vocabulary(it) %>%
  prune_vocabulary(doc_proportion_max = 0.1, term_count_min = 5)
vectorizer = vocab_vectorizer(v)
dtm = create_dtm(it, vectorizer)

# Topic modeling using LDA: currently we set the number of topics as 10. 
it = itoken(events$name, progressbar = TRUE)
v = create_vocabulary(it) %>%
  prune_vocabulary(doc_proportion_max = 0.1, term_count_min = 5)
vectorizer = vocab_vectorizer(v)
dtm = create_dtm(it, vectorizer)
k = 5
a = 0.2
t = 0.07

lda_model = LDA$new(n_topics = k, doc_topic_prior = a, topic_word_prior = t)
doc_topic_distr = lda_model$fit_transform(x = dtm, n_iter = 1000,
                                          convergence_tol = 0.001, n_check_convergence = 25,
                                          progressbar = TRUE)

lda_model$plot() #viz
events$topic <- 0

for (i in 1:nrow(events)){
  print (i)
  events$topic[i] <- which.max(doc_topic_distr[i,])
}

# merging topics to venues: "events or activities"
venues <- venues %>% left_join(events[,c("venue_id", "topic")], by=c("venue_id"))

clusters <- kmeans(venues[,2:4], 5)
venues$cluster <- clusters$cluster
venues$cluster <- as.factor(venues$cluster)

map <- get_map(location = 'Washinton DC', zoom = 11, color = "bw")
mapPoints <- ggmap(map) + 
  geom_point(aes(x=lon, y=lat, color=cluster), data = venues[,c("lon", "lat", "cluster")], alpha=1) + ggtitle("clusters")
mapPoints
