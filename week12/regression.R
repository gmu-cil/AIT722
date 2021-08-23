library(stringr)
library(readr)
library(dplyr)
library("PerformanceAnalytics")


setwd("~/git/AIT722/week12")

# Regressions
regress <- function (dv, iv, rate){
  operator<-" ~ "
  rhs<-iv
  
  model_1 <- paste0(
    dv,
    operator,
    rhs
  ) %>% as.formula
  
  fit <- lm(model_1, data=rate)
  print(summary(fit))
  print(anova(fit))
}

rate <- read_delim("data_28cities.csv", delim = ",",col_names = TRUE)

rate$city <- as.factor(rate$city)
rate <- rate[,-16]
rate$std_events <- rate$event_total / rate$pop

d <- density(rate$std_events)
plot(d, "std_events density")
polygon(d, col="red", border="blue")

# descriptive correlation table
chart.Correlation(rate[,5:ncol(rate)], histogram=TRUE, pch=19)

# standard number of events as DV
regress("std_events", "poverty_index", rate)
regress("rsvp", "poverty_index + pop", rate)

# what happens if you control for other variables?
regress("rsvp", "poverty_index + commute_time_min", rate)
regress("rsvp", "poverty_index + cultural_diversity", rate)
regress("std_events", "poverty_index + commute_time_min", rate)
regress("std_events", "poverty_index + cultural_diversity", rate)

# what kinds of community features give rise to people's participation in events?
regress("rsvp", "cultural_diversity + pop", rate)
regress("rsvp", "ethnic_heterogeneity + pop", rate)

# how are ethnic_heterogeneity related to poverty level?
regress("ethnic_heterogeneity", "poverty_index", rate)
