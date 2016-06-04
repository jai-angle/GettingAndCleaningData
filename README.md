#Getting and Cleaning Data - Course Project

This repository is created as part of the Getting and Cleaning Data project to
demonstrate the ability to collect, work with and clean the data set.

Data for this project comes from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

This represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data is dowloaded using the script **DownloadGandCData.R**.

As per the requirement of the project, script **run_analysis.R** is created to achieve all the
following required steps:-
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of 
   each variable for each activity and each subject.

The script assumes that the data is downloaded and is extracted in the directory "UCI HAR Dataset".
The script performs all the steps as required for the project and the snippet of the output of each
step is shown in CodeBood.md file.


The order in which the scripts are executed is as follows:-

	DownloadGandCData.R (run only once to download the data)
	run_analysis.R	

The description of the variables, code, transformation and sample output is shown in **CodeBook.md**.

And the final tidy data is stored in the file **TidyData.txt**.


