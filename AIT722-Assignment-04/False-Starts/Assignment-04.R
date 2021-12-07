# 2021-11-29 M.Willis - Assignment 4 - based on M.Lee sample Week 12 code.
#
library(stringr)
library(readr)
library(dplyr)
library(lmerTest)
library("PerformanceAnalytics")


setwd("~/git/AIT722/week12")  # location of data file

# Regressions

# Linear Regression - dv = dependent variable; iv = independent variable; data
# 1:59:00
regress <- function (dv, iv, data){
  operator<-" ~ "
  rhs<-iv
  model_1 <- paste0(dv,operator,rhs) %>% as.formula
  fit <- lm(model_1, data=data)  # running the linear regression model here.  "lm" means linear model (02:19:10 ref). Most basic, ordinary, least of square
  print(summary(fit))
  # print(anova(fit))
  
}

# Multi-level Regression  (as in recent paper, the authors were looking for expecting certain char's nested within geo boundaries)
#     Exactly same as previous function, except for "lmer" instead of "lm" to run multi-level regression. (02:20:30 backtrack in video)
multi_level_regress <- function (dv, iv, data){
  operator<-" ~ "
  rhs<-iv
  
  model_1 <- paste0(dv, operator, rhs) %>% as.formula
  fit <- lmer(model_1, data=data)  # "lmer" = multi-level regression (from the lmerTest library)
  print(summary(fit))
  # print(anova(fit))
}

# 2:00:09
# 28 cities' data from June 2018. 
#   Counted # RSVPs, Population for City (census), Total # events in the City, Cultural Diversity based on Rao's measurements, Ethnic Heterogeneity (based on census data then calculated using HHI index), 
#   Citizen Pct (as opposed to foreigners), Gini = social economic inequality - socioeconomic segregation in the city (also available from the census), median age (census), Commute time (census), 
#   pct over 65 (census), pct below bachelor's (census), state, poverty index (calculated by combining the median income, education level, and several other variables - a Principal Component Analysis was performed) 

# of events and RSVPs can be viewed as community-engagement measurements 02:03:40
#   more organizing and participation = more community engagement
rate <- read_delim("data_28cities.csv", delim = ",",col_names = TRUE)

rate$city <- as.factor(rate$city)               # City as a factor, a categorical variable
rate$state <- as.factor(rate$state)             # State as a factor (character field = you must make them factors, categorical variables)
rate$std_events <- rate$event_total / rate$pop  # Rather calculate the # of events, you calculate the NORMALIZED value - how many events per individual. "std_events"
hist(rate$std_events, breaks=28)                # Breaks = # of bars (28 cities = 28 bars); 02:07:00
hist(log(rate$std_events), breaks=28)           # You can also look at the logarithm - a little more evenly distributed (if too skewed, then regression results not reliable).
                                                #   In this case, we'll keep the original data, since it okay.
d <- density(rate$std_events)                   # density is smoother; alternative to seeing the histogram. good bell shape then don't take the logs. 02:08:10
plot(d, "std_events density")
polygon(d, col="red", border="blue")

# descriptive correlation table
chart.Correlation(rate[,5:15], histogram=TRUE, pch=19)  # 02:08:30 / 02:09:30 -> charted. 
# 02:10:00 Explanation: 
# Red dots show the significance level in the Pearson Correlation: 
#   3 asterisks means p value is less than 0.001; 1 asterisk means p < 0.05; no dot = not statistically significant
#   If there's a strong correlation between variables, you shouldn't put them together. This is a way of identifying multi-colinearity across teh variables


# Multi-level Regression 02:10:55

# standard number of events as DV
regress("std_events", "poverty_index", rate)        # How much poverty can predict the number of events. 
                                                    #      Poverty negatively correlated + low p-value = strong negative correlation. High poverty = low events.
regress("std_events", "poverty_index + pop", rate)  # Control based on population - maybe population itself has some impact on meetup data. 
                                                    #      If lots of density, maybe there's more impact... RUN -- still significant; pop doesn't have much impact on # of events.
regress("rsvp", "poverty_index + pop", rate)        # Same for RSVP. (Events is from organizer perspective. RSVP is from participant perspective): 
                                                    #      low p and high negative correlation, even after controlling for population 


# Other variables to consider: 02:14:05

# what happens if you control for other variables?
# RSVPs:
regress("rsvp", "poverty_index + commute_time_min + cultural_diversity + pop", rate)       # control for commute time, cult div, and pop
regress("rsvp", "poverty_index + cultural_diversity", rate)                                # control for cultural div
#
# Events:
regress("std_events", "poverty_index + commute_time_min + cultural_diversity + pop", rate) # control for commute time, cult div, and pop
regress("std_events", "poverty_index + cultural_diversity", rate)                          # control for cult div


# what kinds of community features give rise to people's participation in events?
regress("rsvp", "cultural_diversity + pop", rate)
regress("rsvp", "ethnic_heterogeneity + pop", rate)

# how are ethnic_heterogeneity related to poverty level? 02:18:05 - not correlated in this data set
regress("poverty_index", "ethnic_heterogeneity + commute_time_min + median_age + percent_65_over", rate)  

# Multi-level Regressions
#
# The "(1 | state)" puts the "random effect" on the state - the state may be shaping the organization of events. 
#     Several cities belong to one state - more than one city belongs to same state. 
#     This "random effect" on those states -> then we can see the random variations based on those states.
# 02:22:30. State is the factor; 1|state means they have different intercepts. (slopes similar; different intercepts - state effects) 
#     The multi-level regression can be constructed in different ways:
#     * If we want to model for different states w/ different slopes, then we could model something like (02:25:00) like (poverty_index | state). 
#     * Theoretically, justifying different slopes is hard (not mechanically), so you use a random effect model with differnet intercepts, but the same slope
#     * It needs the (1 | state) or it is not multi-level.  (02:28:30)
multi_level_regress("rsvp", "poverty_index + commute_time_min + cultural_diversity + pop + (1 | state)", rate)
# (above) note the random effect now in the result - random effects are calculated per state; still see the pov index negatively correlated. 
#     Results are consistent between linear and multi-level regression models

# In the linear model, there was no correlation. What if we change to multi-level? Same. (actually, a worse p-value than before. No significant impact.)
multi_level_regress("poverty_index", "ethnic_heterogeneity + commute_time_min + median_age + percent_65_over + (1 | state)", rate)

# Other Notes (02:29:30)
# Regression requires two variables. Before you run regression analysis, a useful website to consult is "power analysis calculator" -- 
#    decide the numbers required to understand some phenomena
#    https://clincalc.com/stats/samplesize.aspx

#
# !!! For each question, provide: !!!
# (1) the model used, 
# (2) results (e.g., beta cofficients, F-statistics, p-value, graphs, etc.), and 
# (3) the interpretation of the results.)
# !!!
#

### New Code - for Assignment 4:
# a. How does ethnic heterogeneity affect the poverty level for the given 28 cities, when controlling for the percentage of citizens?
regress("poverty_index", "ethnic_heterogeneity + citizen_percent", rate)
multi_level_regress("poverty_index", "ethnic_heterogeneity + citizen_percent + (1 | state)", rate)

# b. How does poverty affect people's participation in events (i.e., RSVPs) for the given 28 cities, when controlling for the population?
regress("rsvp", "poverty_index + pop", rate)
multi_level_regress("rsvp", "poverty_index + pop + (1 | state)", rate)

# c. How does poverty affect people's participation in events (i.e., RSVPs) for the given 28 cities, when controlling for the population and Gini index?
regress("rsvp", "poverty_index + pop + gini", rate)
multi_level_regress("rsvp", "poverty_index + pop + gini + (1 | state)", rate)

# d. How is socio-economic inequality (i.e., Gini index) related to poverty for the given 28 cities?
regress("gini", "poverty_index", rate)
multi_level_regress("gini", "poverty_index + (1 | state)", rate)

# e. How is socio-economic inequality (i.e., Gini index) related to the number of events per capita for the given 28 cities?
regress("gini", "std_events", rate)
multi_level_regress("gini", "std_events + (1 | state)", rate)

## Here, I add an "anova" version of the regression calculation functions, though we could have just modified the original to take an extra parm:
anova_regress <- function (dv, iv, data){
  operator<-" ~ "
  rhs<-iv
  model_1 <- paste0(dv, operator, rhs) %>% as.formula
  fit <- lm(model_1, data=data)
  print(anova(fit))
}
anova_multi_level_regress <- function (dv, iv, data){
  operator<-" ~ "
  rhs<-iv
  model_1 <- paste0(dv, operator, rhs) %>% as.formula
  fit <- lmer(model_1, data=data)  # "lmer" = multi-level regression (from the lmerTest library)
  print(anova(fit))
}
plant.aov <- anova(lm(weight ~ group, data = PlantGrowth))
plant.aov


# Testing example from https://rpubs.com/aaronsc32/anova-compare-more-than-two-groups
library (ggplot2)
library (car)
data ("PlantGrowth")
ggplot(PlantGrowth, aes(weight)) + 
  geom_density(aes(data = weight, fill = group), position = 'identity', alpha = 0.5) +
  labs(x = 'Weight', y = 'Density') + scale_fill_discrete(name = 'Group') + scale_x_continuous(limits = c(2, 8))
qqPlot(PlantGrowth$weight, col = PlantGrowth$group)
plant.aov <- anova(lm(weight ~ group, data = PlantGrowth))
plant.aov
# Learned: there's a mechanism here related to grouping. In our data set, we'll need to code the grouping (or do it by hand :-O )


# f. When 28 cities are categorized into 4 groups based on poverty level (7 cities in each group, based on the order of poverty level), 
#     are there systematic differences in their RSVPs and the number of events per capita between different groups of poverty? Examine this question using ANOVA. 
#     Also, provide a Box plot for showing the differences between the groups. ANOVA was not covered in the class, but you can use the "anova()" function 
#     instead of "summary()" to see the significances in R. 

# To do this, we need to add a column that creates the 4 "blocks". We know we have 28 rows, so once they are sorted accordingly the groups can be created via something like
#   ... group_number = ceiling(rownumber/7), which gets us 4 evenly-sized groups.

rate <-rate[order(rate$poverty_index),]                     # first, sort by poverty_index
rate$poverty_group <- ceiling(as.numeric(rownames(rate))/7) # then, add a column using the ceiling function to break into 4 groups
rate %>% as_tibble() %>% print(n=40)                        # check it!

anova_regress("rsvp", "std_events", rate)  # calculate anova regression
boxplot(rsvp~poverty_group,rate)
boxplot(std_events~poverty_group, rate)

# g. When 28 cities are categorized into 4 groups based on the level of socio-economic inequality, i.e., Gini index (7 cities in each group), 
#      are there any systematic differences in their RSVPs and the number of events per capita? Examine this question using ANOVA. 
#      Also, provide a Box plot for showing the differences between the groups. 

# To do this, we need to add a column that creates the 4 "blocks". We know we have 28 rows, so once they are sorted accordingly the groups can be created via something like
#   ... group_number = ceiling(rownumber/7), which gets us 4 evenly-sized groups.
rate <-rate[order(rate$gini),]                           # first, sort by gini value
rate$gini_group <- ceiling(as.numeric(rownames(rate))/7) # then, add a column using the ceiling function to break into 4 groups
rate %>% as_tibble() %>% print(n=40)                     # check it!

anova_regress("rsvp", "std_events,rate")
boxplot(rsvp~gini_group, rate)
boxplot(std_events~gini_group, rate)

