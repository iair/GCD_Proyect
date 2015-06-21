#Proyect GCD

#This part calls the pachages needed to the assignment
library(plyr)
library(dplyr)
library(data.table) 
library(reshape2)

#Get the data from train and test data sets
train_data_x<-read.table("~R/UCI HAR Dataset/train/X_train.txt")
train_data_y<-read.table("~R/UCI HAR Dataset/train/y_train.txt")
test_data_x<-read.table("~R/UCI HAR Dataset/test/X_test.txt")
test_data_y<-read.table("~R/UCI HAR Dataset/test/y_test.txt")
subject_train<-read.table("~R/UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("~R/UCI HAR Dataset/test/subject_test.txt")
#get the activity labels
activity_labels<-read.table("~R/UCI HAR Dataset/activity_labels.txt")
#Get the features
features<-read.table("~R/UCI HAR Dataset/features.txt")

#This are the steps wich i follow to get the tidy data:

#1.-Add the variable name to the head of the test and train x data
c<-as.character(features[,2])
names(test_data_x)<-c
names(train_data_x)<-c

#2.-#this part Extracts only the measurements on the mean and standard deviation 
#for train and test datasets, achieving the point 2 of the evaluation. 
ptn_mean_std<-"(Mean|mean|Std|std)"
c_test_mean_std<-grep(ptn_mean_std,names(test_data_x),perl=T)
c_train_mean_std<-grep(ptn_mean_std,names(train_data_x),perl=T)
train_data_x<-train_data_x[,c_train_mean_std]
test_data_x<-test_data_x[,c_test_mean_std]

#3.-Create the diccionary for the activity of every observation using join
activity_test<-join(x = test_data_y,y = activity_labels, by="V1",type = "left")
activity_train<-join(x = train_data_y,y = activity_labels, by="V1",type = "left")
#delete the data wich you are not going to use anymore
rm(train_data_y); rm(test_data_y);rm(activity_labels);rm(c);rm(features);
rm(ptn_mean_std)

#4.-Join the activity with the data of the mesures
test_data<-cbind(activity=activity_test[,2],test_data_x)
train_data<-cbind(activity=activity_train[,2],train_data_x)
#delete the data wich you are not going to use anymore
rm(activity_test);rm(activity_train);rm(test_data_x);rm(train_data_x)

#5 Join the identification of the person with the observations
names(subject_test)<-"subject"
names(subject_train)<-"subject"
test_data<-cbind(subject=subject_test,test_data)
train_data<-cbind(subject=subject_train,train_data)
#delete the data wich you are not going to use anymore
rm(subject_test);rm(subject_train)

#5.-Merge the test(above) with the training(under) sets to create the data set
#this part achieve the task 4 of the evaluation "Merges the training and the test sets to create one data set"
data_set<-rbind(test_data,train_data)
data_set$activity<-as.character(data_set$activity)
#delete the data wich you are not going to use anymore
rm(c_test_mean_std);rm(c_train_mean_std)

#6.-This part achieve the point 3 of the evaluation, appropriately labels the 
#data sets with descriptive variable names following the instructions in the
#lectures:all lower case when possible,not duplicated and not have unerscores
#or dot or white spaces.I did?t make the names more descriptive becouse i think 
#the variable names would be too long, and you can go to the codebook for the 
#description of every variable
names(data_set)<-tolower(names(data_set))
for (i in 1:length(names(data_set))){
        names(data_set)[i]<-gsub("-","",names(data_set)[i])
        names(data_set)[i]<-gsub("[:(:]","",names(data_set)[i])
        names(data_set)[i]<-gsub("[:):]","",names(data_set)[i])
        names(data_set)[i]<-gsub(",","",names(data_set)[i])
        names(data_set)[i]<-gsub("^t", "time",names(data_set)[i])
        names(data_set)[i]<-gsub("^f", "frequency",names(data_set)[i])
        names(data_set)[i]<-gsub("Acc", "Accelerator",names(data_set)[i])
        names(data_set)[i]<-gsub("Mag", "Magnitude",names(data_set)[i])
        names(data_set)[i]<-gsub("Gyro", "Gyroscope",names(data_set)[i])
}


#7.-This part achieve the point 5 of the evaluation:From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject. 
data_set.dt<-data.table(data_set)
tidy_data <- data_set.dt[, lapply(.SD, mean), by = 'subject,activity']
tidy_data<-tidy_data[order(tidy_data$subject),]
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

#If you want to test the tidy data you can create a csv file and open it in a excel sheet 
#with this code: write.csv(tidy_data, file = "tidy_data.csv", row.names = FALSE)

#If you want to test that the headers are not in the values part of the data set
#you can compare this: head(data_set[2948,1:3]) and head(train_data[1,1:3])
#wich shows you the 2948 row of the data sets is the values of the first row
#of the train data, so thats probe it is ok. Also you can make the sum of the 
#dimensions as a validation.

#This way of get the data achieves the point 3 of the evalution:Uses descriptive activity names to name the activities in the data set
#gives us descriptive activity names for the activities in the data set. You can validate that running this code:unique(data_set[,2])
#wich gives you the six activities:WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING, STANDING, LAYING 



