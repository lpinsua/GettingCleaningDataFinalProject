#### John's Hopkins University
#### Data Science Specialization
#### Getting and Cleaning Data
#### Final Course Project
#### Luis Pedro Insua

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
testsubject <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
## Create dataframe with means and stdevs, then give columns friendlier names
test <- data.frame(testsubject,testactivity,testmeans,teststdevs)
names(test)<- c("subject","activity","mean","stdev")


##### Loading and preparing train data

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


##### 1) Merging taining and test sets into one dataset
traintest <- rbind(train,test)


##### 3) Use descriptive activity names to name the activities in the data set

## Load activity label data
activitylabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
names(activitylabels) <- c("code","activityName")
## Add activity names to the dataframe
traintest<-left_join(traintest,activitylabels, by=c("activity"="code"))
head(traintest)
# Select only necessary variables
traintest <- select(traintest,activityName,subject, mean, stdev)


##### 5) Tidy summary

## Group dataframe by subject and activity
traintest <- group_by(traintest,activityName,subject)
## Create summary with averages by activity and subject
summary <- summarize(traintest,mean(mean),mean(stdev))


###### FINAL RESULTS
## Look at the tidy datasets
head(traintest)
head(summary)
## Export them to .csv files
write.csv(traintest,file="traintest.csv")
write.csv(summary,file="summary.csv")
