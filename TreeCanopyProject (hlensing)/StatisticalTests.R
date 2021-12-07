library(stringr)
library(readr)
library(dplyr)
library(lmerTest)
library("PerformanceAnalytics")
library(tidyverse)
library(ggpubr)
library(rstatix)
library(dplyr)
library(ggplot2)

#------------------------------------------------------------------------------------
# Functions, Data Ingest, Normality Testing, and Transformation

# Linear Regression Model Function
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
# Muliple Linear Regression Model Function
multi_level_regress <- function (dv, iv, data){
  operator<-" ~ "
  rhs<-iv
  
  model_1 <- paste0(
    dv,
    operator,
    rhs
  ) %>% as.formula
  
  fit <- lmer(model_1, data=data)
  # print(summary(fit))
  print(anova(fit))
}

# read csv of city data and save into rate variable
rate <- read.csv("/Users/lensingh/PycharmProjects/TreeCanopyProject2/UTC_Census_Data_Merged.csv", sep = "," ,head = TRUE)

hist(rate$Tree.Canopy.in.acres, breaks=366)
hist(log(rate$Tree.Canopy.in.acres), breaks=366)

chart.Correlation(rate[3:5], histogram=TRUE, pch=19)
rate$PovertyPerCapita <- rate$Income.in.the.past.12.months.below.poverty.level/rate$Total.Population
rate$Total.White.Population.Percent <- rate$Total.White.Population/rate$Total.Population
rate$Total.African.American.Population.Percent <- rate$Total.African.American.Population/rate$Total.Population
rate$Total.American.Indian.Population.Percent <- rate$Total.American.Indian.Population/rate$Total.Population
rate$Total.Asian.Population.Percent <- rate$Total.Asian.Population/rate$Total.Population
rate$Total.Native.Hawaiian.Population.Percent <- rate$Total.Native.Hawaiian.Population/rate$Total.Population


rate$PovertyPerCapita[is.infinite(rate$PovertyPerCapita)] <- 0
# total land, total area, total surface water, imperv, veg
regress("Urban.Tree.Canopy.area.percent", "Total.Area.in.acres + Total.Land.Area.in.acres + 
        Total.Impervious.Area.in.percent + Surface.Water.Area.in.percent + Vegetation.Percentage + 
        Median.household.income.in.the.past.12.months + Total.Population + 
        Total.White.Population + Total.Asian.Population + Total.African.American.Population +
        Total.American.Indian.Population + Total.Native.Hawaiian.Population", rate)

regress("Urban.Tree.Canopy.area.in.acres", "Total.Area.in.acres + Total.Land.Area.in.acres + 
        Total.Impervious.Area.in.acres + Surface.Water.Area.in.acres + Vegetation.in.acres + 
        Median.household.income.in.the.past.12.months + Total.Population + 
        Total.White.Population.Percent + Total.Asian.Population.Percent + Total.African.American.Population.Percent +
        Total.American.Indian.Population.Percent + Total.Native.Hawaiian.Population.Percent", rate)

regress("Urban.Tree.Canopy.area.percent", "Total.Population + Total.White.Population.Percent + Total.African.American.Population.Percent + Median.household.income.in.the.past.12.months + Total.American.Indian.Population.Percent + Total.Native.Hawaiian.Population.Percent + rate$Total.Asian.Population.Percent", rate)

regress("Urban.Tree.Canopy.area.in.acres", "Soil.area.in.acres + Total.Possible.Planting.Area.in.acres + Median.household.income.in.the.past.12.months + Total.White.Population", rate)

regress("Urban.Tree.Canopy.area.percent", "Income.in.the.past.12.months.below.poverty.level + PovertyPerCapita + Median.household.income.in.the.past.12.months + Total.Population + Total.White.Population + Total.African.American.Population + Total.American.Indian.Population + Total.Asian.Population +Total.Native.Hawaiian.Population", rate)

# check to see the relationship between the two variables
regress("Urban.Tree.Canopy.area.percent", "Median.household.income.in.the.past.12.months", rate)

# adding control doesn't change significance much here
regress("Urban.Tree.Canopy.area.percent", "Median.household.income.in.the.past.12.months + Total.Population", rate)

rate$UTC_quart <- with(rate, cut(Urban.Tree.Canopy.area.percent, breaks=quantile(Urban.Tree.Canopy.area.percent, 
                                                                    probs=seq(0,1,by=0.25)), include.lowest=TRUE, labels=c("Q1", "Q2","Q3","Q4")))
rate$UTC_quart <- as.factor(rate$UTC_quart)
res.aov <- rate %>% anova_test(Median.household.income.in.the.past.12.months ~ UTC_quart)
res.aov

boxplot(Median.household.income.in.the.past.12.months~UTC_quart,data=rate, main="Median Household Income by UTC Percentage in CBGs",
        xlab="UTC Percentage in CBG", ylab="Median Household Income by CBG", col=(c("darkseagreen1", "cadetblue3", "darkslateblue", "darkslategray")))

boxplot(Urban.Tree.Canopy.area.percent~UTC_quart,data=rate, main="UTC Percentage in CBGs",
        xlab="Quartiles of UTC Percentage in CBG", ylab="UTC Percentage in CBG", col=(c("darkseagreen1", "cadetblue3", "darkslateblue", "darkslategray")))

summary(rate$Urban.Tree.Canopy.area.percent)


ggplot(rate, aes(x=Median.household.income.in.the.past.12.months, y=Urban.Tree.Canopy.area.in.acres)) + 
  geom_point() + geom_smooth(method = "lm")

rate$UTCacres_quart <- with(rate, cut(Urban.Tree.Canopy.area.in.acres, breaks=quantile(Urban.Tree.Canopy.area.in.acres, 
                                                                                 probs=seq(0,1,by=0.25)), include.lowest=TRUE, labels=c("Q1", "Q2","Q3","Q4")))
rate$UTCacres_quart <- as.factor(rate$UTCacres_quart)
res.aov <- rate %>% anova_test(Median.household.income.in.the.past.12.months ~ UTCacres_quart)
res.aov

boxplot(Median.household.income.in.the.past.12.months~UTCacres_quart,data=rate, main="Median Household Income by UTC Percentage in CBGs",
        xlab="UTC Acreage in CBG", ylab="Median Household Income by CBG", col=(c("darkseagreen1", "cadetblue3", "darkslateblue", "darkslategray")))

rate$income_quart <- with(rate, cut(Median.household.income.in.the.past.12.months, breaks=quantile(Median.household.income.in.the.past.12.months, 
                                                                                 probs=seq(0,1,by=0.25)), include.lowest=TRUE, labels=c("Q1", "Q2","Q3","Q4")))
rate$income_quart <- as.factor(rate$income_quart)

# priority_df <- rate[,c("UTC_quart", "Total.Possible.Planting.Area.in.percent", "Possible.Vegetation.Planting.Area.in.percent", "income_quart")]

write.csv(rate,"/Users/lensingh/PycharmProjects/TreeCanopyProject2/PriorityCBG.csv", row.names = TRUE)
