---
title: "Codebook for tidy dataset from Getting and Cleaning Data Course project"
author: "Ksushis"
date: "11/22/2015"
output:
  html_document:
    keep_md: yes
---

## Project Description
The purpose of this poject was to demostrate my ability to collect, work with, and clean a data set. 
The goal was to prepare tidy data that can be used for later analysis based on some parameters (to be described later in this Codebook).

##Study design and data processing

###Collection of the raw data
The raw data was collected from the accelerometers from the Samsung Galaxy S smartphone. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The raw data was obtained from the following url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



##Creating the tidy datafile

###Guide to create the tidy data file

1. Download the data from the following URL: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Extract the .zip file into a working directory (you should get a UCI HAR Dataset folder)

3. Run [run_analysis.R file] (https://github.com/Ksushis/getting-and-cleaning-data-course-project/blob/master/run_analysis.R) (see ReadMe.md file [README file](https://github.com/Ksushis/getting-and-cleaning-data-course-project/blob/master/README.md) for more details). The script contains extensive comments for each step in the cleaning and creating a tidy dataset process

The script will generate tidydataset data.frame with tidy data. You can optionally save the dataset to file (see [README file](https://github.com/Ksushis/getting-and-cleaning-data-course-project/blob/master/README.md) for more details). 

The tidydataset data.frame created with run_analysis.R script has the following attributes of tidy data:
* 1 variable per column, 
* each column is labeled, 
* there are no duplicate columns.

###Cleaning of the data

The following cleanup of the raw data from the original dataset (available here [](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) has been performed:

1. The training and the test sets were merged to create one data set.
2. Only the mean and standard deviation for each measurement were left in the dataset. I only left the variables that had mean() and std() in their names since those corresponded to the mean and std of the variables. For examples, I excluded meanFreq() etc. features based on the description in the features_info.txt file in the original dataset (the features_info.txt file is available if you download the raw dataset, see it for more details). The description of the features said that features with mean() and std() were the mean and standard diviation of the corresponding measurements, whereas "meanFreq() was "Weighted average of the frequency components to obtain a mean frequency", which is not just the mean of the measurement.I also excluded the features like "angle(tBodyGyroJerkMean,gravityMean)" because they were not the "mean of the measurement"
3. I created descriptive names for the acitivities (see ActivityLabel desciption below)
4. To clean up the names of the features to make them more creative, I deleted "()" from the names in "mean()" and "std()", replaced "Acc" in the names with "Acceleration", replaced "Mag" in the names with with "Magnitude" 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In particular, the tidy dataset has the following 68 columns:

###AcitivityLabel 

Describes the type of activity, a factor with levels: 

WALKING

WALKING_UPSTAIRS

WALKING_DOWNSTAIRS

SITTING

STANDING

LAYING

###Subject 

An identifier of the subject who carried out the experiment, a factor with integer numbers between 1 and 30 (inclusive) for levels.

### Variables 3-68 - average of the mean or std of corresponding measurement for each activity and subject

Variable name scheme:

1. Each variable name starts with domain denomination (t for time, f for frequency).

2. There were 2 types of signals recorded, one from accelerator, the other from gyroscope. The Acceleration signal was further broken down into BodyAcceleration and GravityAcceleration parts. The names have Gyro for gyroscope. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccelerationJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccelerationMagnitude, tGravityAccelerationMagnitude, tBodyAccelerationJerkMagnitude, tBodyGyroMagnitude, tBodyGyroJerkMagnitude). 

3. The name contains the type of statistics applied (mean or std)

4. The name has Axis (x, y, or z)

The names of the variables are:

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

##Sources
I found the following sources helpful for this project: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ http://www.statmethods.net/input/valuelabels.html (for step 3) http://stackoverflow.com/questions/12064202/using-aggregate-for-multiple-aggregations (for step 5)
https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41#file-gistfile1-rmd (template for the codebook)
