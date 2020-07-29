### John's Hopkins University
### Data Science Specialization
### Getting and Cleaning Data
### Final Course Project
### Luis Pedro Insua

######################### SETUP AND PREPARATION ##############################

library(dplyr)

## Download data as zip, then unzip inside working directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")

## Read files and assign dataframes
features <- read.table(".\\UCI HAR Dataset\\features.txt",col.names = c("n","variable"))
activities <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",col.names=c("activityCode","activity"))
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt",col.names="subject")
X_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt",col.names=features$variable)
y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt",col.names="activityCode")
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt",col.names="subject")
X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt",col.names=features$variable)
y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt",col.names="activityCode")



############################## STEPS 1 - 5 ###################################

## STEP 1: Merges the training and the test sets to create one data set.
X <- rbind(X_train,X_test)
Y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)
merged <- cbind(subject, Y, X)

## STEP 2: Extracts only the measurements on the mean and standard deviation 
##         for each measurement.
extracted <- merged %>% select(subject, activityCode, contains("mean"),
                               contains("std"))
## STEP 3: Uses descriptive activity names to name the activities 
##         in the data set.
extracted$activityCode <- activities[extracted$activityCode,2]

## STEP 4: Appropriately labels the data set with descriptive variable names.
names(extracted)[2] <- "activity"
names(extracted) <- gsub("^t","time",names(extracted))
names(extracted) <- gsub("^f","freq",names(extracted))
names(extracted) <- gsub("\\.","",names(extracted))
names(extracted) <- gsub("std","STD",names(extracted))
names(extracted) <- gsub("gravity","Gravity",names(extracted))
names(extracted) <- gsub("mean","Mean",names(extracted))
names(extracted) <- gsub("^anglet","angleTime",names(extracted))
names(extracted) <- gsub("Acc","Accelerometer",names(extracted))
names(extracted) <- gsub("Gyro","Gyroscope",names(extracted))


## STEP 5: From the data set in step 4, creates a second, independent tidy 
##         data set with the average of each variable for each activity and 
##         each subject.
summary <- extracted %>% group_by(subject,activity) %>%
                summarize_all(funs(mean))

## Export table to a txt file
write.table(summary,file="summary.txt",row.names = FALSE)
