##This r script prepares a tidy data set for the recordings of 30 subjects
##performing activities of daily living while carrying a waist-mounted
##smartphone with embedded inertial sensors

library(dplyr)

##Download file into R
if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/UCIdataset.zip")
unzip(zipfile = "./data/UCIdataset.zip", exdir = "./data")

##Read test data into R
test_results <- read.table("./data/UCI HAR DATASET/test/X_test.txt", header = FALSE)
test_subjects <- read.table("./data/UCI HAR DATASET/test/subject_test.txt", header = FALSE)
test_activity <- read.table("./data/UCI HAR DATASET/test/y_test.txt", header = FALSE)
test_data <- cbind(test_subjects, test_activity, test_results)

##Read training data into R
train_results <- read.table("./data/UCI HAR DATASET/train/X_train.txt", header = FALSE)
train_subjects <- read.table("./data/UCI HAR DATASET/train/subject_train.txt", header = FALSE)
train_activity <- read.table("./data/UCI HAR DATASET/train/y_train.txt", header = FALSE)
train_data <- cbind(train_subjects, train_activity, train_results)

##Merge the data sets
merged_data <- rbind(test_data, train_data)

##Label data set with descriptive variable names
var_names <- read.table("./data/UCI HAR DATASET/features.txt")
var_names <- as.vector(var_names[,2])
var_names <- gsub("-","",var_names)
var_names <- gsub("\\()","",var_names)
var_names <- gsub("mean","Mean",var_names)
var_names <- gsub("std","STD",var_names)
var_names <- gsub("freq","Frequency",var_names)
var_names <- gsub("Acc","Accelerometer",var_names)
var_names <- gsub("Mag","Magnitude",var_names)
var_names <- gsub("Gryo","Gyroscope",var_names)
colnames(merged_data) <- c("subject", "activity", var_names)

##extract mean and std variables
merged_data <- select(merged_data, c("subject", "activity") 
                      | contains("mean") 
                      | contains("std"))


##Assign descriptive activity names to data set
merged_data$activity <- factor(merged_data$activity)
levels(merged_data$activity)[1:6] <- c("WALKING", "WALKING_UPSTAIRS",
                                       "WALKING_DOWNSTAIRS", "SITTING",
                                       "STANDING", "LAYING")

##Create tidy data set
tidy_data <- aggregate(. ~subject + activity, merged_data, mean)
tidy_data <- tidy_data[order(tidy_data$subject, tidy_data$activity), ]
write.table(tidy_data, "tidy_data.txt", row.names = FALSE, quote = FALSE)
