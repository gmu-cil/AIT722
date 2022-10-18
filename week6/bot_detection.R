library(ggplot2)
library(stringr)
library(readr)
library(dplyr)
library(reshape2)
library(PerformanceAnalytics)
library(rtweet)
library(tweetbotornot2) # library from https://github.com/mkearney/tweetbotornot
library(devtools)
remotes::install_github("mkearney/tweetbotornot2")


setwd("~/git/AIT722/week6/")


####################
# Determining whether bot or not (based on either user names or their tweets)
####################

auth_setup_default()

corona_tweets <- read.csv("data/user_names.csv")

## select users
users <- corona_tweets$screen_name
users <- unique(users)

## get botornot estimates
data <- predict_bot(users[1:100])

## arrange by prob ests
head(data[order(-data$prob_bot), ])

# what about yours?
tweetbotornot(c("deeperlee"))

# Futher class activites 
# 1. try to collect 10,000 tweets about particular topic.
# 2. remove duplicate users 
# 3. create a network of these users.
# 4. see how the networks look different before and after removing bots. 
