#loading required package
library(dplyr)
filename <- "Coursera_Assignment_Final.zip"

# Checking if archieve already exists and downloading
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileURL, filename, method="curl")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

#activities performed with its codes 
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#test data of 9/30 volunteer test subjects being observed
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

#recorded features of test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

#test data of activities code labels
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

#train data of 21/30 volunteer subjects being observed
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

#recorded features train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

#train data of activities code labels
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#merges training and test datasets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X) 

#Extracts only the measurements on the mean and standard deviation for each measurement. 
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std")) 

TidyData$code <- activities[TidyData$code, 2] #Uses descriptive activity names to name the activities in the data set

#Appropriately labels the data set with descriptive variable names. 
names(TidyData)[2] = "activity" #code renamed into activities
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData)) #Acc renamed into accelerometer
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData)) #Gyro renamed into Gyroscope
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData)) #BodyBody renamed into Body
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData)) #Mag renamed into Magnitude
names(TidyData)<-gsub("^t", "Time", names(TidyData)) #t renamed into Time
names(TidyData)<-gsub("^f", "Frequency", names(TidyData)) #f renamed into Frequency
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData)) #tBody renamed into TimeBody
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE) #-mean renamed into Mean
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE) #-std renamed into STD
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE) #-freq renamed into Frequency
names(TidyData)<-gsub("angle", "Angle", names(TidyData)) #angle renamed into Angle
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData)) #gravity renamed into Gravity


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

str(FinalData)
