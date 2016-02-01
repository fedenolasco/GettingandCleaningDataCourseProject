# GettingandCleaningDataCourseProject
The purpose of this project demonstrates the ability to collect, work with, and clean a data set.
# Getting and cleaning data
Human Activity Recognition Using Smartphones Dataset http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Files and Datasource:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
•	README.md -- you are reading it right now
•	CodeBook.md -- codebook describing variables, the data and transformations
•	run_analysis.R -- actual R code
# run_analysis.R goals
The purpose is to create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The output is created in working directory with the name of tidydata1.txt and tidydata2.txt
# run_analysis.R steps
Step 1: Tidy test data and train data and include only mean and std variables.
Load names for feature vectors
Determine column labels that match mean or std
dataset 1: load test data.
Load subjects
Load activity data
Load 561 vectors
Extracts only the measurements on the mean and standard deviation for each measurement
Build tidy dataset 1 with test data; source, activities, subjects and vectors
dataset 2: training data
Load activity data
Load subjects
Load 561 vectors
Extracts only the measurements on the mean and standard deviation for each measurement
Build tidy dataset 2 with train data; source, activities, subjects and vectors
Step 2: Merge data of test- and train datasets and include descriptive activity names
load activity labels
remove underscore and convert to lowercase activity label
merge test data and train data
convert to data.frame to use aggregate function
write the resulting datasets for upload tidydata01 and tidydata02
