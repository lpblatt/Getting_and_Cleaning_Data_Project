##This r script prepares a tidy data set for the recordings of 30 subjects
##performing activities of daily living while carrying a waist-mounted
##smartphone with embedded inertial sensors

##Read test data into R
test_results <- read.table("./data/test/X_test.txt", header = FALSE)
test_subjects <- read.table("./data/test/subject_test.txt", header = FALSE)
test_activity <- read.table("./data/test/y_test.txt", header = FALSE)
test_data <- cbind(test_subjects, test_activity, test_results)

##Read training data into R
train_results <- read.table("./data/train/X_train.txt", header = FALSE)
train_subjects <- read.table("./data/train/subject_train.txt", header = FALSE)
train_activity <- read.table("./data/train/y_train.txt", header = FALSE)
train_data <- cbind(train_subjects, train_activity, train_results)

##Merge the data sets
merged_data <- rbind(test_data, train_data)

##Label data set with descriptive variable names
var_names <- read.table("./data/features.txt")
var_names <- as.vector(var_names[,2])
var_names <- gsub("-","",var_names)
var_names <- gsub("\\()","",var_names)
colnames(merged_data) <- c("subject", "activity", var_names)

##extract mean and std variables
merged_data <- select(merged_data, c("subject", "activity") 
                      | contains("mean") 
                      | contains("std"))
merged_data <- merged_data[,1:82]

##Assign descriptive activity names to data set
merged_data$activity <- factor(merged_data$activity)
levels(merged_data$activity)[1:6] <- c("WALKING", "WALKING_UPSTAIRS",
                                       "WALKING_DOWNSTAIRS", "SITTING",
                                       "STANDING", "LAYING")

##Create second data set
avg_data <- aggregate(merged_data[, 3:81], 
                        by = list(activity=merged_data$activity,
                                  subject=merged_data$subject), 
                        FUN = mean)


