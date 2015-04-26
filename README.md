Course Project

Use the datasets from the following archive https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (Full Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Notes: This assignment was fulfilled by writing one (longish) R script - run_Analsys.R which reads the metadata and observations from the various files as describe in the codebook.

Data from the "training" and "testing" observations are narrowed to variables of interest, then merged into one large dataset "Observations".

Observations is not output, however it is used as basis for a summary dataset (as per #5 above) which is then saved to disc as "Project Tidy.txt".
