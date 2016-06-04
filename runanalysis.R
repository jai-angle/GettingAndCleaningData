# runanalysis.R is created as part of the Getting and Cleaning Data project to
# demonstrate the ability to collect, work with and clean the data set.

# The code performs all the steps as required for the project and the snippet of
# the output of each step is shown in CodeBood.md file.

# run_analysis.R achieves the following:-

#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement.
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names.
#  5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.

# 
# Load all the library required to accomplish the task
library(dplyr)
library(data.table)
library(tidyr)


# Initialize the file location -- will be used everywhere later
FileLocation      <- "./UCI HAR Dataset"

# Initialize the directory location - better to do it here for easy reading 
TrainDir          <- "train"
TestDir           <- "test"

# Initialise the file variable here - easier to understand the code later
SubjectTrainFile  <- "subject_train.txt"
SubjectTestFile   <- "subject_test.txt"
XTrainFile        <- "X_train.txt"
XTestFile         <- "X_test.txt"
YTrainFile        <- "y_train.txt"
YTestFile         <- "y_test.txt"
FeaturesFile      <- "features.txt"
ActLabelFile      <- "activity_labels.txt"


#######################################################################################
#   Read all the files required for the assignment
#######################################################################################

# Actual Data Files:-
ActTrainData      <- tbl_df(read.table(file.path(FileLocation, TrainDir, XTrainFile )))
ActTestData       <- tbl_df(read.table(file.path(FileLocation, TestDir , XTestFile )))

# Activity Files:-
ActivityTrainData <- tbl_df(read.table(file.path(FileLocation, TrainDir, YTrainFile)))
ActivityTestData  <- tbl_df(read.table(file.path(FileLocation, TestDir , YTestFile )))

# Subject Files:-
SubjectTrainData  <- tbl_df(read.table(file.path(FileLocation, TrainDir, SubjectTrainFile)))
SubjectTestData   <- tbl_df(read.table(file.path(FileLocation, TestDir, SubjectTestFile )))

# Features File:-
FeaturesData      <- tbl_df(read.table(file.path(FileLocation, FeaturesFile)))

# Activity Label File:-
activityLabels<- tbl_df(read.table(file.path(FileLocation, ActLabelFile)))


# Now we have loaded all the required data. Next step is to accomplish the task as required
# by the step as mentioned with the number below:-

# 1. Merges the training and the test sets to create one data set.

MergedSubjectData   <- rbind(SubjectTrainData, SubjectTestData)
MergedActivityData  <- rbind(ActivityTrainData, ActivityTestData)

# Rename the column V1 appropriately
setnames(MergedSubjectData, "V1", "subject")
setnames(MergedActivityData, "V1", "activityNum")

# set the appropriate column name for the features data
setnames(FeaturesData, names(FeaturesData), c("featureNum", "featureName"))

# set the appropriate column names for activity labels data
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))

#combine the DATA training and test files and rename the column such as V1 = "tBodyAcc-mean()-X"
dataTable           <- rbind(ActTrainData, ActTestData)
colnames(dataTable) <- FeaturesData$featureName


# Merge all the data set together
MergedSubjAct       <- cbind(MergedSubjectData, MergedActivityData)
MergedDataTable     <- cbind(MergedSubjAct, dataTable)

# Task 1 accomplished...MergedDataTable is one data set as requested.

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# get only mean and std deviation data
FeaturesMeanStd   <- grep("mean\\(\\)|std\\(\\)",FeaturesData$featureName,value=TRUE)

FeaturesMeanStd   <- union(c("subject","activityNum"), FeaturesMeanStd)
MergedDataTable   <- subset(MergedDataTable,select=FeaturesMeanStd) 

# Task 2 accomplished... and all the data has only std and mean


# 3 Uses descriptive activity names to name the activities in the data set

MergedDataTable <- merge(activityLabels, MergedDataTable , by="activityNum", all.x=TRUE)
MergedDataTable$activityName <- as.character(MergedDataTable$activityName)

# Task 3 accomplished... Detail output in .rmd

# 4. Appropriately labels the data set with descriptive variable names.

names(MergedDataTable)<-gsub("BodyBody", "Body", names(MergedDataTable))
names(MergedDataTable)<-gsub("Mag", "Magnitude", names(MergedDataTable))
names(MergedDataTable)<-gsub("std()", "SD", names(MergedDataTable))
names(MergedDataTable)<-gsub("mean()", "MEAN", names(MergedDataTable))
names(MergedDataTable)<-gsub("^t", "time", names(MergedDataTable))
names(MergedDataTable)<-gsub("^f", "frequency", names(MergedDataTable))
names(MergedDataTable)<-gsub("Acc", "Accelerometer", names(MergedDataTable))
names(MergedDataTable)<-gsub("Gyro", "Gyroscope", names(MergedDataTable))



# Taks 4 accomplished...Detail output in .rmd

# 5. From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.


AggrData  <- aggregate(. ~ subject - activityName, data = MergedDataTable, mean) 
MergedDataTable <- tbl_df(arrange(AggrData, subject, activityName))

# Write the final tidy data to TidyData.txt file
write.table(MergedDataTable, "TidyData.txt", row.name=FALSE)
