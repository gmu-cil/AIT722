library(stringr)
library(readr)
library(dplyr)
library(lmerTest)
library("PerformanceAnalytics")


setwd("~/git/AIT722/week12")

# Regressions
regress <- function (dv, iv, data){
  operator<-" ~ "
  rhs<-iv
  
  model_1 <- paste0(
    dv,
    operator,
    rhs
  ) %>% as.formula
  
  fit <- lm(model_1, data=data)
  print(summary(fit))
  # print(anova(fit))
}

multi_level_regress <- function (dv, iv, data){
  operator<-" ~ "
  rhs<-iv
  
  model_1 <- paste0(
    dv,
    operator,
    rhs
  ) %>% as.formula
  
  fit <- lmer(model_1, data=data)
  print(summary(fit))
  # print(anova(fit))
}

rate <- read_delim("data_28cities.csv", delim = ",",col_names = TRUE)

rate$city <- as.factor(rate$city)
rate$state <- as.factor(rate$state)
rate$std_events <- rate$event_total / rate$pop
rate$std_rsvp <- rate$rsvp / rate$pop
hist(rate$std_events, breaks=28)
hist(log(rate$std_events), breaks=28)
d <- density(rate$std_events)
plot(d, "std_events density")
polygon(d, col="red", border="blue")

# descriptive correlation table
chart.Correlation(rate[,5:15], histogram=TRUE, pch=19)

# standard number of events as DV
regress("std_events", "poverty_index", rate)
regress("std_events", "poverty_index + pop", rate)
regress("rsvp", "poverty_index + pop", rate)

shapiro.test(rate$ethnic_heterogeneity)

# what happens if you control for other variables?
regress("rsvp", "poverty_index + commute_time_min + cultural_diversity + pop", rate)
regress("rsvp", "poverty_index + cultural_diversity", rate)
regress("std_events", "poverty_index + commute_time_min + cultural_diversity + pop", rate)
regress("std_events", "poverty_index + cultural_diversity", rate)

# what kinds of community features give rise to people's participation in events?
regress("rsvp", "cultural_diversity + pop", rate)
regress("std_rsvp", "ethnic_heterogeneity + pop + state", rate)

# how are ethnic_heterogeneity related to poverty level?
regress("poverty_index", "ethnic_heterogeneity + commute_time_min + median_age + percent_65_over", rate)

# Multi-level Regressions
multi_level_regress("std_events", 
                    "ethnic_heterogeneity + commute_time_min + pop + (1 | state)", rate)

multi_level_regress("std_events", 
                    "poverty_index + ethnic_heterogeneity + commute_time_min + cultural_diversity + pop +
                    (1 | state)", rate)

multi_level_regress("std_rsvp", 
                    "poverty_index + ethnic_heterogeneity + commute_time_min + cultural_diversity + pop +
                    (1 | state)", rate)

multi_level_regress("poverty_index", 
        "ethnic_heterogeneity + commute_time_min + median_age + percent_65_over + 
        (1 | state)", rate)
