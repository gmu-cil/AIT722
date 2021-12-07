# 2021-11-29 M.Willis - Assignment 4 - Compact final version. Based on M.Lee Week 12 code.
library(stringr)
library(readr)
library(dplyr)
library(lmerTest)
library("PerformanceAnalytics")

setwd("~/git/AIT722/week12")

rate <- read_delim("data_28cities.csv", delim = ",",col_names = TRUE)

rate$city <- as.factor(rate$city)               # City as a factor, a categorical variable
rate$state <- as.factor(rate$state)             # State as a factor (character field = you must make them factors, categorical variables)
rate$std_events <- rate$event_total / rate$pop  # Rather calculate the # of events, you calculate the NORMALIZED value - how many events per individual. "std_events"

#chart.Correlation(rate[,5:15], histogram=TRUE, pch=19)  # 02:08:30 / 02:09:30 -> charted. descriptive correlation table

# a. How does ethnic heterogeneity affect the poverty level for the given 28 cities, when controlling for the percentage of citizens?
plot (rate$ethnic_heterogeneity, rate$poverty_index, xlab="Ethnic Heterogeneity", ylab="Poverty Index")   # x, y 
plot(rate$poverty_index~rate$ethnic_heterogeneity,xlab="Ethnic Heterogeneity",ylab="Poverty Index")  # y~x
abline(lm(poverty_index~ethnic_heterogeneity,data=rate),col='red',lwd=2)  # y~x

result <- regress("poverty_index", "ethnic_heterogeneity + citizen_percent", rate, TRUE)
abline(result,lwd=2)
result <- multi_level_regress("poverty_index", "ethnic_heterogeneity + citizen_percent + (1 | state)", rate, TRUE)
print(result)

# b. How does poverty affect people's participation in events (i.e., RSVPs) for the given 28 cities, when controlling for the population?
plot(rate$rsvp~rate$poverty_index,xlab="Poverty Index",ylab="RSVPs")  #y~x
plot(rate$poverty_index, rate$rsvp,xlab="Poverty Index",ylab="RSVPs") #x,y
abline(lm(rsvp~poverty_index,data=rate),col='red',lwd=2)  # y~x  -- seems easier than the functions with left/right hand side, since we have built-ins already.
abline(lmer(rsvp~poverty_index + pop + (1 | state), rate))

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


