#### Coursera: Getting and Cleaning Data Course Project

library(tidyverse)

# download the dataset from url
if(!file.exists("data")) {
    dir.create("data")
}

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="./data/project_dataset.zip")
unzip("./data/project_dataset.zip", exdir="./data")

# take a look at how the dataset looks like
readLines("./data/UCI HAR Dataset/train/X_train.txt", n=10)
readLines("./data/UCI HAR Dataset/train/X_test.txt", n=10)

# import data
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=F)
Y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=F)
names(Y_train) <- "Activity"
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=F, stringsAsFactors=F)
names(sub_train) <- "Subject"

X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=F)
Y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=F)
names(Y_test) <- "Activity"
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=F, stringsAsFactors=F)
names(sub_test) <- "Subject"

features <- read.table("./data/UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)
labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=F, stringsAsFactors=F)


## 1. Merge the training and the test sets to create on data set

merged <- rbind(cbind(Y_train, sub_train, X_train),
                cbind(Y_test, sub_test, X_test))

# convert activity and subject into factors
for (i in c(1, 2)) {
    merged[[i]] <- as.factor(merged[[i]])
}


## 3. Use decriptive activity names to name the activities in the dataset

Activity_label <- c(labels$V2)
names(Activity_label) <- labels$V1

merged$Activity <- Activity_label[merged$Activity]


## 4. Label the dataset with descriptive variable names

names(merged)[3:ncol(merged)] <- features$V2


## 2. Extract only the measurements on the mean
## and the standard deviation for each measurement

merged_mean_std <- merged[,c(1, 2, grep("(mean\\W)|(std\\W)", names(merged)))]
merged_mean_std[1:6, 1:6]


## 5. Create a second, independent dataset with the average of
## each variable for each activity and each subject

merged_summarized <- aggregate(merged[,3:ncol(merged)],
                               by=list(Subject=merged$Subject, Activity=merged$Activity), mean)
merged_summarized[1:6, 1:6]
write.table(merged_summarized, "project_submission.txt", row.names=F)
