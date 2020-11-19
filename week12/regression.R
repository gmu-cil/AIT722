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

# what happens if you control for other variables?

# what kinds of community features give rise to people's participation in events?

# how are ethnic_heterogeneity related to poverty level?

