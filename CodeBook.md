# Getting and Cleaning Data Project Codebook
This code book describes the variables, the data, and any transformations or work performed to clean up the data from the Human Activity Recognition Using Smartphones Data Set.

## Variables
### Identifying/Summary Variables
* subject - identifies which volunteeer subject the data corresponds 
* activity - identifies which activity the subject was performing

### Data variables

For each feature vector in the data set (and for each for each pattern), the mean and stand deviation were summarized by subject and activity. Time domain signals ("t") and frequency domain signals ("f") were captured and calculated for each feature. Feature vetor variables included in the final output tidy_data.txt file include:
* tBodyAccelerometer                                       
* tGravityAccelerometer                 
* tBodyAccelerometer
* tBodyAccelerometerJerk
* tBodyGyro
* tBodyGyroJerk
* tBodyAccelerometerMagnitude
* tGravityAccelerometer     
* tBodyAccelerometerJerkMagnitude
* tBodyGyroMagnitude
* tBodyGyroJerkMagnitude
* fBodyAccelerometer                                       
* fGravityAccelerometer                 
* fBodyAccelerometer
* fBodyAccelerometerJer
* fBodyGyro
* fBodyGyroJerk
* fBodyAccelerometerMagnitude
* fGravityAccelerometer     
* fBodyAccelerometerJerkMagnitude
* fBodyGyroMagnitude
* fBodyGyroJerkMagnitude

Additionally, angles between two vectors two vectors from the raw dataset are summarized by patient and activity. Angles include:
* angle(tBodyAccelerometerMean,gravity)
* angle(tBodyAccelerometerJerkMean),gravityMean)
* angle(tBodyGyroMean,gravityMean)
* angle(tBodyGyroMean,gravityMean)
* angle(X,gravityMean)
* angle(Y,gravityMean)
* angle(Z,gravityMean


## Data and Transformations
Data was obtained from the Human Activity Recognition Using Smartphones Data Set from UC Irvine. 

The following steps were performed to download, transform, and create the tidy data set in tidy_data.txt:
1. Download the zip file from the UCI website, unzip the file, and place the contents in a "./data" directory
2. Read the test results, test subjects, and test activity files into R using read.table() function
    * combine the three files into 1 test data set using cbind() function
3. Read training results, training subjects, and training activity files into R using read.table() function
    * combine the three files into 1 training data set using cbind() function
4. Merge the test and training results using rbind() function
5. Label the column names using descriptive variable names from the feautures file
    * Read the features file into R
    * Use gsub() function to add more description to variable names
    * Assign column names to the merged data set
6. Extract mean and standard deviation variables from merged data using select() function
7. Assign descriptive activity names to activities
    * Use factor() function to create factors based on activity 
    * Assign descriptive label depending on the levels 1:6 using levels() function
8. Create tidy data set
    * Use aggregate() function to calculate the mean based on the subject and activity columns
    * Order the data by subject and activity using the order() function
    * Create "tidy_data.txt" file using write.table() function









