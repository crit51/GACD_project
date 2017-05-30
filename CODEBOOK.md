# CODEBOOK

## Source data

This project used the dataset named `Human Activity Recognition Using Smartphones` (link below). This data was collected from the accelerometers from the Samsung Galaxy S smartphone.

Link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Explanation of variables and the steps that I performed

- `X_train`, `Y_train`, `sub_train`, `X_test`, `Y_test`, `sub_test`, `features`, and `labels`<br> are from the source data.<br>

- In `merged`<br>, all of the above data are merged. First, `Y_train`, `sub_train`, `X_train` are merged with `cbind`<br> and the same for the test sets. Then, those train and test sets are merged with `rbind`.

- After that, I named the variables appropriately using the names in the `features` dataset.

- In order to give descriptive names to the activities in the dataset, I first made a character vector variable named `Activitiy_label`. Then, I named each descriptive activity name as from 1 to 6 to correspond to the coded numbers in the original dataset. That is, `Activity_label` looks liks this:

```
> Activity_label
                   1                    2                    3                    4 
           "WALKING"   "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS"            "SITTING" 
                   5                    6 
          "STANDING"             "LAYING"
```

This way, we can extract the descriptive activity names by using the coded numbers. This was done by using this code:

```
merged$activity <- Activity_label[merged$activity]

```

- `extracted`<br>
From `merged` dataset, only the measurements on the mean and standard deviation for each measurement are extracted.

- `tidy_data`
The average of each variable is summarized by each activity and each subject using `aggregate` function. And then, this dataset is arranged by subject ID. This data is saved as `run_analysis.txt` for submission.