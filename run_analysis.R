

### Load required packages
library(dplyr)

##### Downloading data

## Download data as zip, then unzip inside working directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")

##### Loading and preparing test data

## Read complete test table
testdata <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
## Calculate means and standard deviations for each measurement
testmeans <- rowMeans(testdata)
teststdevs <- apply(testdata,1,FUN=sd)
testactivity <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
## Create dataframe with means and stdevs, then give columns friendlier names
test <- data.frame(testactivity,testmeans,teststdevs)
names(test)<- c("activity","mean","stdev")


## Read complete train table
traindata <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
## Calculate means and standard deviations for each measurement
trainmeans <- rowMeans(traindata)
trainstdevs <- apply(traindata,1,FUN=sd)
trainactivity <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
trainsubject <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
## Create dataframe with means and stdevs, then give columns friendlier names
train <- data.frame(trainsubject,trainactivity,trainmeans,trainstdevs)
names(train)<- c("subject","activity","mean","stdev")

head(train)
head(test)

rbind(train,test)
