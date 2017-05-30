library(dplyr)

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
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=F, stringsAsFactors=F)

X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=F)
Y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=F)
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=F, stringsAsFactors=F)

features <- read.table("./data/UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)
labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=F, stringsAsFactors=F)


## 1. Merge the training and the test sets to create on data set

merged <- rbind(cbind(Y_train, sub_train, X_train),
                cbind(Y_test, sub_test, X_test))


## 4. Appropriately label the dataset with descriptive variable names

names(merged) <- c("activity", "subject", features$V2)


## 3. Use decriptive activity names to name the activities in the dataset

Activity_label <- c(labels$V2)
names(Activity_label) <- labels$V1
merged$activity <- Activity_label[merged$activity]


## 2. Extract only the measurements on the mean and
## standard deviation for each measurement

indices <- grep("(activity)|(subject)|(mean\\(\\))|(std\\(\\))", names(merged))
extracted <- merged[,indices]

# check if I stepped all of the steps right
extracted[1:6, 1:6]


## 5. Create a second, independent dataset with the average of
## each variable for each activity and each subject

tidy_data <-
    aggregate(extracted[,3:ncol(extracted)],
              by=list(subject=extracted$subject, activity=extracted$activity), mean) %>%
    arrange(subject)

write.table(tidy_data, "run_analysis.txt", row.names=F)
