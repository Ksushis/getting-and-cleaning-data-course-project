# How to use run_analysis.R script
run_analysis.R script creates a tidy data dataset from the UCI HAR Dataset

The UCI HAR dataset data is available here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
For smoothest results, download the .zip file from the link above, extract it into a working directory (it will create a UCI HAR Dataset folder), copy the run_analysis.R file into the working directory and run it.

If you already have the dataset available, make sure run_analysis.R script is in the same folder as the UCI HAR Dataset folder. UCI HAR Dataset folder must contain at least the following:
* test folder with X_train.txt and y_train.txt files inside
* train folder with X_train.txt and y_train.txt files inside
* activity_labels.txt file
* features.txt file
* features_info.txt file

The script follows these steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement (see Codebook for more information).
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tidy dataset created by the script is tidydataset data.frame with 68 columns with the following names:

ActivityLabel

Subject

tBodyAcceleration-mean-X

tBodyAcceleration-mean-Y

tBodyAcceleration-mean-Z

tGravityAcceleration-mean-X

tGravityAcceleration-mean-Y

tGravityAcceleration-mean-Z

tBodyAccelerationJerk-mean-X

tBodyAccelerationJerk-mean-Y

tBodyAccelerationJerk-mean-Z

tBodyGyro-mean-X

tBodyGyro-mean-Y

tBodyGyro-mean-Z

tBodyGyroJerk-mean-X

tBodyGyroJerk-mean-Y

tBodyGyroJerk-mean-Z

tBodyAccelerationMagnitude-mean

tGravityAccelerationMagnitude-mean

tBodyAccelerationJerkMagnitude-mean

tBodyGyroMagnitude-mean

tBodyGyroJerkMagnitude-mean

fBodyAcceleration-mean-X

fBodyAcceleration-mean-Y

fBodyAcceleration-mean-Z

fBodyAccelerationJerk-mean-X

fBodyAccelerationJerk-mean-Y

fBodyAccelerationJerk-mean-Z

fBodyGyro-mean-X

fBodyGyro-mean-Y

fBodyGyro-mean-Z

fBodyAccelerationMagnitude-mean

fBodyBodyAccelerationJerkMagnitude-mean

fBodyBodyGyroMagnitude-mean

fBodyBodyGyroJerkMagnitude-mean

tBodyAcceleration-std-X

tBodyAcceleration-std-Y

tBodyAcceleration-std-Z

tGravityAcceleration-std-X

tGravityAcceleration-std-Y

tGravityAcceleration-std-Z

tBodyAccelerationJerk-std-X

tBodyAccelerationJerk-std-Y

tBodyAccelerationJerk-std-Z

tBodyGyro-std-X

tBodyGyro-std-Y

tBodyGyro-std-Z

tBodyGyroJerk-std-X

tBodyGyroJerk-std-Y

tBodyGyroJerk-std-Z

tBodyAccelerationMagnitude-std

tGravityAccelerationMagnitude-std

tBodyAccelerationJerkMagnitude-std

tBodyGyroMagnitude-std

tBodyGyroJerkMagnitude-std

fBodyAcceleration-std-X

fBodyAcceleration-std-Y

fBodyAcceleration-std-Z

fBodyAccelerationJerk-std-X

fBodyAccelerationJerk-std-Y

fBodyAccelerationJerk-std-Z

fBodyGyro-std-X

fBodyGyro-std-Y

fBodyGyro-std-Z

fBodyAccelerationMagnitude-std

fBodyBodyAccelerationJerkMagnitude-std

fBodyBodyGyroMagnitude-std

fBodyBodyGyroJerkMagnitude-std

If you would like to create a file tidydataset.txt with the tidy dataset inside, run the following (after running the run_analysis.R script) (this code is commented out in the script in case you don't want to create a new file each time you run the script): 

write.table(tidydataset, file="tidydataset.txt",row.name=FALSE)

If you have a tidydataset.txt file with the tidy dataset you would like to view, run the following (assuming the tidydataset.txt file is the file with tidy data in the current folder(this code is commented out in the script in case you don't want to create a new file each time you run the script):
This step assumes the file was written with write.table(tidy_data, file="tidydataset.txt",row.name=FALSE) command

tidydataset_from_file <- read.table("tidydataset.txt", header = TRUE) 

View(tidydataset_from_file)

I found the following sources helpful for this project:

* https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
* http://www.statmethods.net/input/valuelabels.html  (for step 3)
* http://stackoverflow.com/questions/12064202/using-aggregate-for-multiple-aggregations (for step 5)
