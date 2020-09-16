# this file predicts poverty index in Milan, Italy, using CDR and OpenStreetMap features.

library(readr)
library(dplyr)
library(magrittr)
library(cwhmisc)
library(utils)
library(rpart)
library(stringr)
library(hydroGOF)
library(fields)
library(MASS)
library(e1071)
library(Hmisc)
library(randomForest)
library(caret)
library(reshape2)

setwd("~/git/AIT722/week4")

census <- read.csv("CDR_features.csv")  # ML features, already generated. 
cluster3 <- read_delim("k3_cluster.csv", delim=",", col_names=TRUE) # Census tract region to cluster matching
colnames(cluster3) <- c("SEZ2011", "cluster3") #these clusters are based on temporal signature of the regions (CDR-based mobility)

# just renaming column names
colnames(census)[9] <- "dep11"
colnames(census)[10] <- "dep01"

# poverty level in 7 bins -- making this as a classification problme
census$dep_class_7 <- as.factor(census$dep_class_7)

# selecting only needed variables
census <- subset(census, select=c(dep_class_7, rand_base, density, spatial_lag, spatial_lag_square, 
                                  dep01, dep11, calls, entropy, eigen_cent, page_rank, region_based_rate, 
                                  commercial, third_places, comm_service, closeness, betweenness, SEZ2011))

census <- census %>% left_join(cluster3, by = c("SEZ2011"))
census$cluster3 <- as.factor(census$cluster3)

# trainset/testset split
target <- census[!is.na(census$commercial),]
index <- 1:nrow(target)
testindex <- sample(index, trunc(length(index) * 0.5 )) # 50% as the testset
testset <- target[testindex,]      
trainset <- target[-testindex,]
row.names(testset) <- testset$SEZ2011
row.names(trainset) <- trainset$SEZ2011

#RF model
model <- randomForest (formula("dep_class_7 ~ spatial_lag_square + closeness + betweenness + 
                               region_based_rate + calls + page_rank + eigen_cent + entropy + 
                               cluster3 + commercial + third_places + comm_service"), 
                       data=trainset, mtry=3,importance=TRUE, proximity=TRUE, na.action=na.omit)
testset <- testset[!is.na(testset$calls) & !is.na(testset$page_rank) & !is.na(testset$eigen_cent)  & 
                     !is.na(testset$entropy) & !is.na(testset$cluster3) & !is.na(testset$region_based_rate) & 
                     !is.na(testset$spatial_lag_square) & !is.na(testset$dep_class_7) & !is.na(testset$commercial) & 
                     !is.na(testset$closeness)& !is.na(testset$betweenness),]

# feature importance
importance(model)

# running the prediction
pred <- predict(model,testset)


# performance measures
tb <- as.matrix(table(Actual = testset$dep_class_7, Predicted = pred)) # confusion matrix
tb 
n = sum(tb)
nc = nrow(tb)
diag = diag(tb)
rowsums = apply(tb, 1, sum)
colsums = apply(tb, 2, sum)

precision = diag / colsums 
recall = diag / rowsums 
F1 <- (2 * precision * recall) / (precision + recall)
F1
mean(F1, na.rm = TRUE)

# can you boost the performance using these features?
