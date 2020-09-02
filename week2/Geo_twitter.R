library(ggplot2)
library(stringr)
library(readr)
library(dplyr)
library(reshape2)
library(PerformanceAnalytics)
library(rtweet)


setwd("~/git/AIT722/week2/")

####################
# Collect geo-tagged Twitter data. 
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


rt <- search_tweets(
  "lang:en", geocode = lookup_coords("usa"), n = 500
)
rt <- lat_lng(rt)

## plot state boundaries
par(mar = c(0, 0, 0, 0))
maps::map("state", lwd = .25)

## plot lat and lng points onto state map
with(rt, points(lng, lat, pch = 20, cex = .75, col = rgb(0, .3, .7, .75)))
rt <- rt[,c("user_id", "status_id", "lng", "lat")]

write.table(rt, "data/tweet_lonlat.csv", row.names = F, sep=",")
