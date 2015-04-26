#   Getting / Cleaning data.  Course Project
#   -----------------------------------------------
#   Here are the data for the project:
#       https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#   You should create one R script called run_analysis.R that does the following.
#       1.  Merges the training and the test sets to create one data set.
#       2.  Extracts only the measurements on the mean and standard deviation
#           for each measurement.
#       3.  Uses descriptive activity names to name the activities in the dataset
#       4.  Appropriately labels the data set with descriptive variable names.
#       5.  From the data set in step 4, creates a second, independent tidy
#           data set with the average of each variable for each activity and
#           each subject.
#   ----------------------------------------------------------------------------
#   Content Overview
#   ----------------
#   The experiments have been carried out with a group of 30 volunteers within
#   an age bracket of 19-48 years. Each person performed six activities
#   (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
#   wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
#   accelerometer and gyroscope, we captured 3-axial linear acceleration and
#   3-axial angular velocity at a constant rate of 50Hz. The experiments have
#   been video-recorded to label the data manually. The obtained dataset has
#   been randomly partitioned into two sets, where 70% of the volunteers was
#   selected for generating the training data and 30% the test data.
#
#   Files:
#   =========================================
#   'README.txt'
#	'features_info.txt': Shows information about the variables used on the feature
#       vector.
#	'features.txt': List of all features.
#	'activity_labels.txt': Links the class labels with their activity name.
#	'train/X_train.txt': Training set.
#	'train/y_train.txt': Training labels.
#	'test/X_test.txt': Test set.
#	'test/y_test.txt': Test labels.
#
#	Notes:
#	======
#	- Features are normalized and bounded within [-1,1].
#	- Each feature vector is a row on the text file.
#
#   Features Info.txt [Excerpt]
#   ---------------
#     tBodyAcc-XYZ
#     tGravityAcc-XYZ
#     tBodyAccJerk-XYZ
#     tBodyGyro-XYZ
#     tBodyGyroJerk-XYZ
#     tBodyAccMag
#     tGravityAccMag
#     tBodyAccJerkMag
#     tBodyGyroMag
#     tBodyGyroJerkMag
#     fBodyAcc-XYZ
#     fBodyAccJerk-XYZ
#     fBodyGyro-XYZ
#     fBodyAccMag
#     fBodyAccJerkMag
#     fBodyGyroMag
#     fBodyGyroJerkMag
#
#     The set of variables that were estimated from these signals are:
#     mean(): Mean value
#     std(): Standard deviation
#     [... and other measures ...]



#   Quick Cleanup of clutter in the environment
rm(list=ls())   # Kill variable
gc()            # Force Garbace Collection

#   =======================
#   Read Names, etc
#   =======================
Subject_Train <- read.table("subject_train.txt",colClasses="character")[,1]
Subject_Test <- read.table("subject_test.txt",colClasses="character")[,1]

#   As the subject numbers overlap, and it's not clear why, we'll force
#   All Training subjects to be prefixed with "train_" and all
#   Testing subjects to be prefixed with "test_"
Subject_Train <- paste0("train_",Subject_Train)
Subject_Test <- paste0("test_", Subject_Test)

#   Get Variable Names
VarNames <- read.delim(file="features.txt",sep="\t", header=FALSE, strip.white=TRUE)[,1]
VarNames <- substring(VarNames, first=4)
VarNames <- trimws(VarNames)
#   Determine the indices of the columns of interest
cols <-grep("std()|mean()", VarNames)               # Those with std/mean
cols<-cols[-grep("meanFreq()", VarNames[cols])]     # Too tight for time - should be done on one stmt

#   ------------------------------
#   Read Observatiosn
#   ------------------------------
#   Read the Training Set - X_train.txt (by inspection, space delimited)
X_Train <- read.table (
                        file = "X_train.txt"
                           , header=FALSE
                           , strip.white = TRUE
                           , col.names = VarNames
                       )
#   let's wittle that down to the std / mean columns
X_Train <- X_Train[,cols]
Subject<-Subject_Train
X_Train <- cbind(Subject, X_Train)

#   Read the Testimg Set - X_test.txt (by inspection, space delimited)
X_Test <- read.table (
    file = "X_test.txt"
    , header=FALSE
    , strip.white = TRUE
    , col.names = VarNames
)
#   let's wittle that down to the std / mean columns
X_Test <- X_Test[,cols]
Subject<-Subject_Test
X_Test <- cbind(Subject, X_Test)


#   We now have two datasets of identical structure, but varying lengths
#   With the exception of the Subject column, each data element name is
#   true with that of the original.  As we made no transformations on th
#   observations, this seems appropriate.

#   We now merge these two datasets to complete assignment objectives 1..4
Observations <- rbind(X_Test, X_Train)
#c(length(X_Test[,1]),length(X_Train[,1]),length(Observations[,1]))
head(Observations)

#   Clean up
rm(X_Test)
rm(X_Train)
rm(Subject)
rm(Subject_Test)
rm(Subject_Train)

#   Second dataset
library("reshape2")
Obs_Reshaped <- dcast(
                        melt(
                            Observations
                            ,id="Subject"
                            , measure.vars=
                                    colnames(Observations)[2:ncol(Observations)]
                            )
                        , Subject~variable
                        ,mean
                        )
write.table(Obs_Reshaped,"Project_Tidy.txt",row.names=FALSE)
