#GCD_Proyect

##UCI HAR Dataset analysis

This repo contains the R scripts that can be used to analysis the UCI HAR Dataset and convert it into a tidy data set.

This was done as the course project for the "Getting and Cleaning Data" course in Coursera which is part of the "Data Science" specialization track.

##Task achieved

This is the proyect of the Getting and Cleaning Data Course, part of the Data Science specilization. Using this data:

I had to create one R script called run_analysis.R that does the following: 

1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement. 

3.Uses descriptive activity names to name the activities in the data set

4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##R 

The R code that is used for analysis is available in the run_analysis.R file.Download this file and put it in a working directory call R. (you can see wich is your actual working directory using the following command: getwd()

Download the UCI HAR Dataset from this link: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and save it on the R working directory.

Source the file in R using the following command and it will automatically download the dataset, perform the transformation, tidy the data and save it in the file tidy_data.txt.

source("run_analysis.R")

The tidy data set can be loaded back into R using the following command

tidy_data <- read.table("tidy_data.txt")

#The Codebook

The codebook available in this repo describes the variables, the data, the transformations that are done and the clean up that was performed on the data.
