# 2021-11-29 M.Willis - Assignment 4 - Compact final version. Based on M.Lee Week 12 code.
library(stringr)
library(readr)
library(dplyr)
library(lmerTest)
library("PerformanceAnalytics")

setwd("~/git/AIT722/week12")
regress <- function (dv, iv, data, is_summary){
  operator<-" ~ "
  rhs<-iv
  model_1 <- paste0(dv,operator,rhs) %>% as.formula
  fit <- lm(model_1, data=data)  # running the linear regression model here.  "lm" means linear model (02:19:10 ref). Most basic, ordinary, least of square
  if (is_summary) { print(summary(fit))} else {print(anova)}
}
multi_level_regress <- function (dv, iv, data, is_summary){
  operator<-" ~ "
  rhs<-iv
  model_1 <- paste0(dv, operator, rhs) %>% as.formula
  fit <- lmer(model_1, data=data)  # "lmer" = multi-level regression (from the lmerTest library)
  if (is_summary) { print(summary(fit))} else {print(anova)}
  }

rate <- read_delim("data_28cities.csv", delim = ",",col_names = TRUE)

rate$city <- as.factor(rate$city)               # City as a factor, a categorical variable
rate$state <- as.factor(rate$state)             # State as a factor (character field = you must make them factors, categorical variables)
rate$std_events <- rate$event_total / rate$pop  # Rather calculate the # of events, you calculate the NORMALIZED value - how many events per individual. "std_events"
hist(rate$std_events, breaks=28)                # Breaks = # of bars (28 cities = 28 bars); 02:07:00
hist(log(rate$std_events), breaks=28)           # You can also look at the logarithm - a little more evenly distributed (if too skewed, then regression results not reliable). In this case, we'll keep the original data, since it okay.
#d <- density(rate$std_events)                   # density is smoother; alternative to seeing the histogram. good bell shape then don't take the logs. 02:08:10
#plot(d, "std_events density")
#polygon(d, col="red", border="blue")

chart.Correlation(rate[,5:15], histogram=TRUE, pch=19)  # 02:08:30 / 02:09:30 -> charted. descriptive correlation table
# a. How does ethnic heterogeneity affect the poverty level for the given 28 cities, when controlling for the percentage of citizens?
plot(rate$poverty_index~rate$ethnic_heterogeneity,xlab="Ethnic Heterogeneity",ylab="Poverty Index")
regress("poverty_index", "ethnic_heterogeneity + citizen_percent", rate, TRUE)
multi_level_regress("poverty_index", "ethnic_heterogeneity + citizen_percent + (1 | state)", rate, TRUE)

# b. How does poverty affect people's participation in events (i.e., RSVPs) for the given 28 cities, when controlling for the population?
plot(rate$rsvp~rate$poverty_index,xlab="Poverty Index",ylab="RSVPs")
abline(regress("rsvp", "poverty_index + pop", rate, TRUE), lwd=2)
regress("rsvp", "poverty_index + pop", rate, TRUE)
multi_level_regress("rsvp", "poverty_index + pop + (1 | state)", rate, TRUE)

# c. How does poverty affect people's participation in events (i.e., RSVPs) for the given 28 cities, when controlling for the population and Gini index?
plot(rate$poverty_index~rate$rsvp,xlab="Poverty Index",ylab="RSVPs")
regress("rsvp", "poverty_index + pop + gini", rate, TRUE)
multi_level_regress("rsvp", "poverty_index + pop + gini + (1 | state)", rate, TRUE)

# d. How is socio-economic inequality (i.e., Gini index) related to poverty for the given 28 cities?
plot(rate$poverty_index~rate$gini,xlab="Gini Index",ylab="Poverty Index")  ## changes?
regress("gini", "poverty_index", rate, TRUE)
multi_level_regress("gini", "poverty_index + (1 | state)", rate, TRUE)

# e. How is socio-economic inequality (i.e., Gini index) related to the number of events per capita for the given 28 cities?
plot(rate$std_events~rate$gini,xlab="Gini Index",ylab="Events per Capita")
regress("gini", "std_events", rate, TRUE) 
multi_level_regress("gini", "std_events + (1 | state)", rate, TRUE)


