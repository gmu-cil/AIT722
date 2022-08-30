library(ggplot2)
library(stringr)
library(readr)
library(dplyr)
library(rrapply)
library(reshape2)
library(PerformanceAnalytics)
library(rtweet)
library(httr)
library(jsonlite)


setwd("~/git/AIT722/week2/")

# Just a Census data collection example.
income_virginia <- read.csv("data/acs2020_virginia.csv")

####################
# Collect geo-tagged Twitter data. 
####################
Sys.setenv(BEARER_TOKEN = "your_bearer_token")
bearer_token <- Sys.getenv("BEARER_TOKEN")
headers <- c(`Authorization` = sprintf('Bearer %s', bearer_token))

## 1. Colelcting particular Twitter user's profile
params <- list(`user.fields` = 'description',
               `expansions` = 'pinned_tweet_id')
# handle can be any Twitter handle to be searched for.
handle <- 'GeorgeMasonU'
url_handle <- sprintf('https://api.twitter.com/2/users/by?usernames=%s', handle)

response <-
  httr::GET(url = url_handle,
            httr::add_headers(.headers = headers),
            query = params)
obj <- httr::content(response, as = "text")
print(obj)


## 2. Searching for random tweets
# In the place of "covid", you can enter any keyword that you want to search upon.
params = list(
  `query` = 'covid lang:en -is:retweet',
  `max_results` = '100',
  `tweet.fields` = 'created_at,text,lang',
  `place.fields` = 'geo',
  `expansions` = 'geo.place_id'
)

response <- httr::GET(url = 'https://api.twitter.com/2/tweets/search/recent', httr::add_headers(.headers=headers), query = params)
obj <- httr::content(response, as = "text")
json <-fromJSON(obj)
tweet_data <- json$data
geo_data <- rrapply::rrapply(json$includes, how = "flatten")
write(toJSON(json$includes), "data/tweet_geo.json")


#############################################
# Old Code: Twitter API Version 1 (doesn't work in V2)
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
