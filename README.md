# GCD_Proyect
This is the proyect of the Getting and Cleaning Data Course, part of the Data Science specilization. Using this data:

I had to create one R script called run_analysis.R that does the following: 

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To achieve this goals i did the following steps:

1.Calls the pachages needed to the assignment: plyr,dplyr, data.table and reshape2. Then i got the the data from train and test data sets in variables to use it in R.

2.-Add the variable name to the head of the test and train x data from the features.

3.Extracts only the measurements on the mean and standard deviation for train and test datasets, achieving the point two of the evaluation.

4.Create the diccionary for the activity of every observation using the join function.

5.Join the activity data with the data of the mesures that i had already create usign the cbind function.

6.-Join the identification of the person with the observations usign the cbind function.

7.-Merge the test(above) with the training(under) sets to create the data. After doing this part, the task four of the evaluation is achieved.

8.-Change the variable names creating descriptive variable names following the instructions in the lectures:all lower case when possible,not duplicated and not have underscores or dot or white spaces. Also,i changed the "t" for "time",the "f" for "frequency",the "Acc" for "accelerator", the "Mag" for magnitude and the "Gyro" for "Gyroscope".
I did not make the names more descriptive becouse i think the variable names would be too long, and you can go to the codebook for the description of every variable.

9.-I created independent tidy data set with the average of each variable for each activity and each subject using the function lapply and by with the data.table package.

If you want to test the tidy data you can create a csv file and open it in a excel sheet 
with this code: write.csv(tidy_data, file = "tidy_data.csv", row.names = FALSE)

If you want to test that the headers are not in the values part of the data set you can compare this: head(data_set[2948,1:3]) and head(train_data[1,1:3]) 
wich shows you the 2948 row of the data sets is the values of the first row of the train data, so thats probe it is ok. Also you can make the sum of thedimensions as a validation.

This way of get the data achieves the point 3 of the evalution:Uses descriptive activity names to name the activities in the data set gives us descriptive activity names for the activities in the data set. You can validate that running this code: unique(data_set[,2])
wich gives you the six activities:WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING, STANDING, LAYING 






