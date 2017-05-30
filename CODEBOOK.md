# CODEBOOK

## Source data

This project used the dataset named `Human Activity Recognition Using Smartphones` (link below). This data was collected from the accelerometers from the Samsung Galaxy S smartphone.

Link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Variables

- `X_train`, `Y_train`, `sub_train`, `X_test`, `Y_test`, `sub_test`, `features`, and `labels`<br>
From the source data<br>

- `merged`<br>
All of the above data are merged. First, `Y_train`, `sub_train`, `X_train` are merged with `cbind`<br> and the same for the test sets. Then, train ans test sets are merged with `rbind`. And then, descriptive activity names (from `labels` data) and descriptive variable names (from `features` data) are labeled appropriately.

- `extracted`<br>
From `merged` dataset, only the measurements on the mean and standard deviation for each measurement are extracted.

- `tidy_data`
The average of each variable is summarized by each activity and each subject using `aggregate` function. And then, this dataset is arranged by subject ID. This data is saved as `run_analysis.txt` for submission.