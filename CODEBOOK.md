# CODEBOOK

## Source data

This project used the dataset named `Human Activity Recognition Using Smartphones` (link below). This data was collected from the accelerometers from the Samsung Galaxy S smartphone.

Link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Explanation of variables and the steps that I performed

- `X_train`, `Y_train`, `sub_train`, `X_test`, `Y_test`, `sub_test`, `features`, and `labels` are from the source data.

- All of the above data are merged into a dataframe named `merged`. First, `Y_train`, `sub_train`, `X_train` are merged with `cbind` and the same for the test sets. Then, those train and test sets are merged with `rbind`.

- After that, I named the variables appropriately using the names in the `features` dataset.

- In order to give descriptive names to the activities in the dataset, I first made a character vector variable named `Activitiy_label`. Then, I named each descriptive activity name as from 1 to 6 to correspond to the coded numbers in the original dataset. That is, `Activity_label` looks liks this:

```
> Activity_label
                   1                    2                    3                    4 
           "WALKING"   "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS"            "SITTING" 
                   5                    6 
          "STANDING"             "LAYING"
```

This way, I was able to extract the descriptive activity names by using the coded numbers. This was done by using the following code:

```
merged$activity <- Activity_label[merged$activity]
```

- Next step was to extract only the measurements on the mean and standard deviation for each measurement. In order to do that, I first created `indices` vaiable for (obviously) indexing. I used `grep()` to get indices of the variable names that contain 'mean()' and 'std()', not to mention 'activity' and 'subject'. And then, I simply extracted only the variables of interest and assign them to a dataframe named `extracted`.

- Finally, I created a `tidy_data` with the average of each variable for each activity and each subject. I used `aggregate()` function. Actually, I tried to use `dplyr::summarize_all()` along with `dplyr::group_by()`, but it raised an error. Anyway, after that, I arranged this dataframe in an ascending order of subject, because I thought this way is right.

- `tidy_data` looks like this:

```
> tidy_data[1:6, 1:6]
  subject           activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
1       1             LAYING         0.2215982      -0.040513953        -0.1132036      -0.92805647
2       1            SITTING         0.2612376      -0.001308288        -0.1045442      -0.97722901
3       1           STANDING         0.2789176      -0.016137590        -0.1106018      -0.99575990
4       1            WALKING         0.2773308      -0.017383819        -0.1111481      -0.28374026
5       1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662       0.03003534
6       1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020      -0.35470803
```

I think I've done it right, but I'm not sure.

- As a last step, I saved `tidy_data` as `run_analysis.txt` using `write,table()` function. This is the submission file.
