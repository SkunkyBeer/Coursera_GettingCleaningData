For our first dataset, Observations (not output) we will not be be doing any transformations on the variables, beyond 
subsetting to only include variables of interest.

A full description of the metadata is given in the file 'features_info.txt', which I've excerpted below

#   Content Overview
   ----------------
   The experiments have been carried out with a group of 30 volunteers within
   an age bracket of 19-48 years. Each person performed six activities
   (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
  wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
   accelerometer and gyroscope, we captured 3-axial linear acceleration and
   3-axial angular velocity at a constant rate of 50Hz. The experiments have
   been video-recorded to label the data manually. The obtained dataset has
   been randomly partitioned into two sets, where 70% of the volunteers was
   selected for generating the training data and 30% the test data.

#   Files:
   --------------
   'README.txt'
	'features_info.txt': Shows information about the variables used on the feature
       vector.
	'features.txt': List of all features.
	'train/X_train.txt': Training set.
	'test/X_test.txt': Test set.
	[ ... other files ...]

#	Notes:
	-------------
	- Features are normalized and bounded within [-1,1].
	- Each feature vector is a row on the text file.

   Features Info.txt
   ---------------
     tBodyAcc-XYZ
     tGravityAcc-XYZ
     tBodyAccJerk-XYZ
     tBodyGyro-XYZ
     tBodyGyroJerk-XYZ
     tBodyAccMag
     tGravityAccMag
     tBodyAccJerkMag
     tBodyGyroMag
     tBodyGyroJerkMag
     fBodyAcc-XYZ
     fBodyAccJerk-XYZ
     fBodyGyro-XYZ
     fBodyAccMag
     fBodyAccJerkMag
     fBodyGyroMag
     fBodyGyroJerkMag

     The set of variables that were estimated from these signals are:
     mean(): Mean value
     std(): Standard deviation
     [... and other measures ...]
#----------------
Upon inspection of the Subject labels for training and testing, it was noted that there was some coincidence in
assignment.  It was not immediately apparent whether or not this was an important distinction.

I therefore decided to preserve the isolation of the two sets of data by prefixing "train_" to the id number of 
each training subject, and "test_" to the id number of each testing subject.

The final output file, Project_Tidy.Txt, is based off the Observations dataset and dcast by mean.
