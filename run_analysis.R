## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#install reshape2 package if missing
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

#load require library
require("data.table")
#require("reshape2")

#Get the activity labels (walking, sitting etc)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
#Assign meaningful labels to activity_labels
names(activity_labels) <- c("Activity_ID","Activity_Type")

#Get column names for X_test and X_train
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#find boolean vector of mean and std features
extract_mean_std <- grepl("mean|std", features) 


X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") #load X_test
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt") #load Y_train

#apply column names to X_test, and X_train
names(X_test) = features
names(X_train) = features

#keep only mean, and std variables; discard rest
X_test = X_test[,extract_mean_std]
X_train = X_train[,extract_mean_std]


y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") #load y_test
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") #load y_train

#assign descriptive labels to y_test, and y_train
names(y_test) = "Activity_ID"
names(y_train) = "Activity_ID"

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt") #load subject_test
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #load subject_train

#assign descriptive labels to subject_test, and subject_train
names(subject_test) = "Subject"
names(subject_train) = "Subject"

#join y_test, y_train with activity labels
y_test <- merge(y_test, activity_labels, by="Activity_ID")
y_train <- merge(y_train, activity_labels, by="Activity_ID")

y_test <- cbind(y_test,Source="TEST")
y_train <- cbind(y_train,Source="TRAIN")

#tag train and test sources
train_data <- cbind(subject_train, y_train, X_train)
train_data <- cbind(subject_train, y_train, X_train)

#combine column-wise for train and test data
train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)

#combine all data row-wise
Combine_All <- rbind(test_data, train_data)

#melt combined data set to make narrow data set
melt_interim <- melt(Combine_All, 1:4)

tidy_data <- dcast(melt_interim, Subject + Activity_ID ~ variable, mean)

#write the tidy data to a txt file
write.table(tidy_data, file = "./tidy_data.txt")
