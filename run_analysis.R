


library(dplyr)


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data.zip")
unzip("data.zip")

test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
test <- tbl_df(test)

test
