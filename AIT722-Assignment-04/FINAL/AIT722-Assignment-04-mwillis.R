# OMG, ITERATION 4...
# 2021-11-29 M.Willis - Assignment 4 - based on M.Lee sample Week 12 code.
#
library(stringr)
library(readr)
library(dplyr)
library(lmerTest)
library("PerformanceAnalytics")
library(ggplot2)


setwd("~/git/AIT722/week12")  # location of data file

# Linear Regression: dv = dependent variable (y); iv = independent variable (x)
regress <- function (dv, iv, data, is_summary){
  operator<-" ~ "
  rhs<-iv
  model_1 <- paste0(dv,operator,rhs) %>% as.formula
  fit <- lm(model_1, data=data)
  if (is_summary) { return(summary(fit))} else {return(anova(fit))}
}
multi_level_regress <- function (dv, iv, data, is_summary){
  operator<-" ~ "
  rhs<-iv
  model_1 <- paste0(dv, operator, rhs) %>% as.formula
  fit <- lmer(model_1, data=data)
  if (is_summary) { return(summary(fit))} else {return(anova(fit))}
}

rate <- read_delim("data_28cities.csv", delim = ",",col_names = TRUE)

rate$city <- as.factor(rate$city)               # City as a factor, a categorical variable
rate$state <- as.factor(rate$state)             # State as a factor (character field = you must make them factors, categorical variables)
rate$std_events <- rate$event_total / rate$pop  # Rather calculate the # of events, you calculate the NORMALIZED value - how many events per individual. "std_events"

# Red dots show the significance level in the Pearson Correlation: 
#   3 asterisks means p value is less than 0.001; 1 asterisk means p < 0.05; no dot = not statistically significant
#   If there's a strong correlation between variables, you shouldn't put them together. This is a way of identifying multi-colinearity across teh variables

# a. How does ethnic heterogeneity affect the poverty level for the given 28 cities, when controlling for the percentage of citizens?
result_a <- regress("poverty_index", "ethnic_heterogeneity + citizen_percent", rate, TRUE)
#multi_level_regress("poverty_index", "ethnic_heterogeneity + citizen_percent + (1 | state)", rate)
print (result_a)

# b. How does poverty affect people's participation in events (i.e., RSVPs) for the given 28 cities, when controlling for the population?
result_b <- regress("rsvp", "poverty_index + pop", rate, TRUE)
#multi_level_regress("rsvp", "poverty_index + pop + (1 | state)", rate)
print(result_b)

# c. How does poverty affect people's participation in events (i.e., RSVPs) for the given 28 cities, when controlling for the population and Gini index?
result_c <- regress("rsvp", "poverty_index + pop + gini", rate, TRUE)
#multi_level_regress("rsvp", "poverty_index + pop + gini + (1 | state)", rate)
print(result_c)

# d. How is socio-economic inequality (i.e., Gini index) related to poverty for the given 28 cities?
result_d <- regress("gini", "poverty_index", rate, TRUE)
#multi_level_regress("gini", "poverty_index + (1 | state)", rate)
print(result_d)

# e. How is socio-economic inequality (i.e., Gini index) related to the number of events per capita for the given 28 cities?
result_e <- regress("gini", "std_events", rate, TRUE)
result_e_lmer <- multi_level_regress("gini", "std_events + (1 | state)", rate, TRUE)
print(result_e)
print(result_e_lmer)

# f. When 28 cities are categorized into 4 groups based on poverty level (7 cities in each group, based on the order of poverty level), 
#     are there systematic differences in their RSVPs and the number of events per capita between different groups of poverty? Examine this question using ANOVA. 
#     Also, provide a Box plot for showing the differences between the groups. ANOVA was not covered in the class, but you can use the "anova()" function 
#     instead of "summary()" to see the significances in R. 

# Add a column to create 4 groups. 28 rows, sorted; created via something like ... group_number = ceiling(rownumber/7), gets us 4 evenly-sized groups.

rate <-rate[order(rate$poverty_index),]                     # first, re-sort by poverty_index
rate$poverty_group <- ceiling(as.numeric(rownames(rate))/7) # then, add a column using the ceiling function to break into 4 groups
#rate %>% as_tibble() %>% print(n=40)                        # check it!

result_f_rsvp <- regress("rsvp", "poverty_group", rate, FALSE)
result_f_std_events <- regress("std_events", "poverty_group", rate, FALSE)
print(result_f_rsvp)
print(result_f_std_events)

boxplot(rate$rsvp~rate$poverty_group, xlab="Poverty Group", ylab="RSVPs")
boxplot(rate$std_events~rate$poverty_group, xlab="Poverty Group", ylab="Events per Capita")

# Sidebar:
qqplot(rate$poverty_index, rate$rsvp, xlab="Poverty Index", ylab="RSVPs")
qqplot(rate$poverty_index, rate$std_events, xlab="Poverty Index", ylab="Events Per Capita")

# g. When 28 cities are categorized into 4 groups based on the level of socio-economic inequality, i.e., Gini index (7 cities in each group), 
#      are there any systematic differences in their RSVPs and the number of events per capita? Examine this question using ANOVA. 
#      Also, provide a Box plot for showing the differences between the groups. 

# As above, add a column to create 4 groups. 28 rows, sorted; created via something like ... group_number = ceiling(rownumber/7), gets us 4 evenly-sized groups.
rate <-rate[order(rate$gini),]                           # first, sort by gini value
rate$gini_group <- ceiling(as.numeric(rownames(rate))/7) # then, add a column using the ceiling function to break into 4 groups
#rate %>% as_tibble() %>% print(n=40)                     # check it!

result_g_rsvp <- regress("rsvp", "gini_group", rate, FALSE)
result_g_std_events <- regress("std_events", "gini_group", rate, FALSE)
print(result_g_rsvp)
print(result_g_std_events)

boxplot(rate$rsvp~rate$gini_group, xlab="Gini Group", ylab="RSVPs")
boxplot(rate$std_events~rate$gini_group, xlab="Gini Group", ylab="Events per Capita")

# Sidebar:
qqplot(rate$gini, rate$rsvp, xlab="Poverty Index", ylab="Events per Capita")
qqplot(rate$gini, rate$std_events, xlab="Poverty Index", ylab="Events per Capita")


