library(dplyr)
library(plyr)

filename <- "human_activity_recognition.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
      unzip(filename) 
}


# 1. Merge the training and test sets to create one data set

# Read training set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Read test set
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# merge x dataset
x_data <- bind_rows(x_train, x_test)

# merge y dataset
y_data <- bind_rows(y_train, y_test)

# merge subject dataset
subject_data <- bind_rows(subject_train, subject_test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("UCI HAR Dataset/features.txt")
valid_column_names <- make.names(features[, 2], unique=TRUE, allow_ = TRUE)
names(x_data) <- valid_column_names

# get only columns with mean() or std() in their names
mean_std_features <- select(x_data, contains("std"), contains("mean"))

# 3. Use descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# 4. Appropriately label the data set with descriptive variable names

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
tidy_data <- bind_cols(mean_std_features, y_data, subject_data)

write.table(tidy_data, "tidy_data.txt", row.name=FALSE)

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

# averaging the data across subject and activity
avg_data <- ddply(tidy_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(avg_data, "tidy_data2.txt", row.name=FALSE)

