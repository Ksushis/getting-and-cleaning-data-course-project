# This is a script to create a tidy dataset from the 
# UCI HAR Dataset 
# The script assumes that it will be run from the folder with 
# a UCI HAR Dateset folder which contains
# * test folder with X_train.txt and y_train.txt files inside
# * train folder with X_train.txt and y_train.txt files inside
# * acitivity_labels.txt file
# * features.txt file
# * features_info.txt file


#1. Merge the training and the test sets to create one data set
# load the data sets. The code assumes you have a UCI HAR Dataset 
# folder in the working directory

data_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
data_test<-read.table("./UCI HAR Dataset/test/X_test.txt")

# read the activity labels
activity_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
activity_test<-read.table("./UCI HAR Dataset/test/y_test.txt")

# read the subject labels
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

# combing the data sets
data<-rbind(cbind(data_train,activity_train,subject_train),
            cbind(data_test,activity_test,subject_test))

# now the first 561 columns are data (features),
# the column=562 is activity (one of 1-6)
# the column=563 is subject

# let's name the columns

# First, read the names of the features from the features.txt file
features_names<-read.table("./UCI HAR Dataset/features.txt",
                           stringsAsFactors = TRUE)

# the feature names are in columns, so let's take the 2nd column of the 
# features_names data.frame and traspose it, so that we could use it 
# to create a vector or names (I used levels() function for this to
# get the strings out of the factor features_names). I also added
# the names for the last 2 columns: Activity and Subject 

names_for_data<-c(as.character(features_names[,2]),"Activity", "Subject")

# now let's create the header for the data using names() function

names(data)<-names_for_data

# Now data is a combined dataset 

#2. Extracts only the measurements on the mean 
# and standard deviation for each measurement. 

# we need to find the features with "mean" and "std" in the name fo the feature
# indices of all the features that have "mean" in the names,
# to exclude entries like meanFreq() etc. I set the fixed=TRUE
# I excluded meanFreq() etc. features based on the description
# in the features_info.txt file. The descriptions said that features with 
# mean() and std() were the mean and standard diviation of the corresponding 
# measurements, "meanFreq() was "Weighted average of the frequency components 
# to obtain a mean frequency", which is not just the mean of the measurement 
# I also excluded the features like "angle(tBodyGyroJerkMean,gravityMean)"
# because they were not the "mean of the measurement"

ind_mean<-grep("mean()",names(data),fixed=TRUE) #exact match for "mean()"

# indices of all the features that have "std" in the names

ind_std<-grep("std()",names(data),fixed=TRUE) #exact match for "std()"

# we are interested in all the columns that have "mean()" and "std()" in them,
# as well as the last 2 columns - Activity and Subject
# columns of interest

ind<-c(ind_mean,ind_std,length(names(data))-1,length(names(data))) 

# data with just means, standard deviations, activity and subject

data_mean_std<-data[,ind]

#3 Uses descriptive activity names to name the activities 
# in the data set

# activity names are in the activity_labels.txt dataset

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")

# name the number column of activity_labels the same name as the numbers in the Activity
# column in the data_mean_std so we could merge the two later
# name the category name as "Activity name"

names(activity_labels)<-c("Activity","Activity name")

# I used example here http://www.statmethods.net/input/valuelabels.html 
# to use factors to recode the Acitivity labels in
# the data.frame data_mean_std


data_mean_std$Activity<-factor(data_mean_std$Activity,
                               levels=activity_labels$Activity,
                               labels = activity_labels$`Activity name`)

# I also made the Subject column a factor, since it's also 
# a set of fixed values, from 1 to 30

data_mean_std$Subject<-factor(data_mean_std$Subject,
                              levels=c(1:30),
                              labels = c(1:30))


#4.Appropriately labels the data set with descriptive 
# variable names. 

# to take a look at the names for the columns,
# execute names(data_mean_std)

# To make the names more descrptive I
# 1. deleted "()" from the names in "mean()" and "std()"
# 2. replace "Acc" with "Acceleration" 
# 3. replaced "Mag" with "Magnitude" 

names(data_mean_std)<-gsub("()","",names(data_mean_std),
                           fixed = TRUE) 

names(data_mean_std)<-gsub("Acc","Acceleration",names(data_mean_std),
                           fixed = TRUE)

names(data_mean_std)<-gsub("Mag","Magnitude",names(data_mean_std),
                           fixed = TRUE)

#5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of each 
# variable for each activity and each subject.

# I used an example here (among others) 
# http://stackoverflow.com/questions/12064202/using-aggregate-for-multiple-aggregations
# to create the dataset with averages of each variable for
# each activity and subject

tidydataset<-aggregate(.~data_mean_std$Activity+data_mean_std$Subject,
          data=data_mean_std,FUN=mean)


# Now the first 2 columns are data_mean_std$Activity and 
# data_mean_std$Subject, with the last 2 columns Acitivity and Subject
# I liked the fact that aggregate put the Activity and Subject 
# columns first, I just didn't like the names of it, so I'll 
# relabel the first 2 columns to be "ActivityLabel" and "Subject" 
# I will also remove the last 2 columns since they're redundant

tidydataset<-tidydataset[,1:length(names(data_mean_std))]

names(tidydataset)[1:2]<-c("ActivityLabel","Subject")

# Uncomment the code below to generate a file

write.table(tidydataset, file="tidydataset.txt",row.name=FALSE)

# To read and view the data, execute the code below,
# assuming the tidydataset.txt file is the file with
# tidy data in the current folder:
# Uncomment the 2 lines below to run the code 
# this step assumes the file was written with 
# write.table(tidy_data, file="tidydataset.txt",row.name=FALSE) 

tidydataset_from_file <- read.table("tidydataset.txt", header = TRUE)
View(tidydataset_from_file)
