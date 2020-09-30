library(ggplot2)
library(stringr)
library(readr)
library(dplyr)
library(reshape2)
library(PerformanceAnalytics)
library(rtweet)
library(tweetbotornot) # library from https://github.com/mkearney/tweetbotornot

setwd("~/git/AIT722/week6/data")


####################
# 1. Collect the data. 
####################

# Twitter Keys
appname <- "myeong_app"
key <- "your_key"
secret <- "your_secret"
access_token <- "access_token"
access_secret <- "access_secret"

twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)

corona_tweets <- search_tweets(q="#Coronavirus", n=100, include_rts = FALSE, lang = "en")
corona_tweets <- corona_tweets[,1:16]

corona_tweets$text <- iconv(corona_tweets$text, from = 'UTF-8', to = 'ASCII//TRANSLIT')
corona_tweets$text <- gsub("(f|ht)tp\\S+\\s*", "", corona_tweets$text)
corona_tweets$text <- gsub("[^-0-9A-Za-z///' ]", " ", corona_tweets$text, ignore.case = TRUE)
corona_tweets$text <- gsub("\\s+"," ",corona_tweets$text)

####################
# 2. Determining whether bot or not (based on either user names or their tweets)
####################

## select users
users <- corona_tweets$screen_name

## get botornot estimates
data <- tweetbotornot(users)

## arrange by prob ests
head(data[order(-data$prob_bot), ])

# what about yours?
tweetbotornot(c("your_twitter_handle"))
