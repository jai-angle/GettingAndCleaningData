#This code downloads the file as required for Getting and Cleaning Data project.

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="Datafile.zip")

###Unzip DataSet to the current directory
unzip("DataFile.zip", exdir =".", overwrite=TRUE)
