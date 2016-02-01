# download zip file and extract content in current work directory
url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(url,mode="wb",temp) 
unzip(temp, exdir=".") # unzip if files/folders and overwrite existing ones
unlink(temp)

###
### Step 1: Tidy test data and train data and include only mean and std variables.
###

## Load names for feature vectors
filepath <-"./UCI HAR Dataset/features.txt"
features <- read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F)
names(features)<-c("id","labels")

## Determine column labels that match mean or std
mean_std_columns<-grep("mean\\(\\)|std\\(\\)", features$labels)
headings<-features[grep("mean\\(\\)|std\\(\\)", features$labels), ]

## dataset 1: load test data.
# Load subjects 
filepath <-"./UCI HAR Dataset/test/subject_test.txt"
test_subjects <- read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F)
names(test_subjects)<-c("subject")

# Load activity data
filepath <-"./UCI HAR Dataset/test/y_test.txt"
test_activities <- read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F)
names(test_activities) <-c("activityid")

# Load 561 vectors
filepath <-"./UCI HAR Dataset/test/X_test.txt"
test_variables <- read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F)
# Extracts only the measurements on the mean and standard deviation for each measurement
test_variables<-test_variables[,mean_std_columns]
names(test_variables)<-headings$labels

# Build tidy dataset 1 with test data; source, activities, subjects and vectors
test_data <- cbind(test_activities,test_subjects,test_variables)


## dataset 2: training data
# Load activity data
filepath <-"./UCI HAR Dataset/train/y_train.txt"
train_activities <- read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F)
names(train_activities) <-c("activityid")

# Load subjects
filepath <-"./UCI HAR Dataset/train/subject_train.txt"
train_subjects <- read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F)
names(train_subjects)<-c("subject")

# Load 561 vectors
filepath <-"./UCI HAR Dataset/train/X_train.txt"
train_variables <- read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F)
# Extracts only the measurements on the mean and standard deviation for each measurement
train_variables<-train_variables[,mean_std_columns]
names(train_variables)<-headings$labels

# Build tidy dataset 2 with train data; source, activities, subjects and vectors
train_data <- cbind(train_activities,train_subjects,train_variables)

###
### Step 2: Merge data of test- and train datasets and include descriptive activity names 
###

## load activity labels
filepath <-"./UCI HAR Dataset/activity_labels.txt"
activities <- data.table(read.table(filepath, sep = "" , header = F ,na.strings ="", stringsAsFactors= F))
names(activities)<-c("activityid","activitylabel")
# remove underscore and convert to lowercase activity label
activities$activitylabel <- tolower(sub("_","",activities$activitylabel))


# merge test data and train data
# 
library (data.table)
dt <- as.data.table(rbind(test_data,train_data))
dt<- merge(dt,activities,by.x="activityid",by.y="activityid",all=TRUE)
dt$activityid <-dt$activitylabel
dt[, activitylabel := NULL]


#convert to data.frame to use aggregate function
dt<-as.data.frame(dt)

# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
average_activity_subject <- aggregate(dt[, 3:ncol(dt)],by=list(subject = dt$subject, label = dt$activityid),mean)


# write the resulting datasets for upload
#
write.table(format(dt, scientific=T), "tidydata01.txt",row.names=F, col.names=F, quote=2)
write.table(format(average_activity_subject, scientific=T), "tidydata02.txt",row.names=F, col.names=F, quote=2)



