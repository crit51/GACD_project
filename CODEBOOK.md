# CODEBOOK

## Source data

This project used the dataset names `Human Activity Recognition Using Smartphones` (link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). This data was collected from the accelerometers from the Samsung Galaxy S smartphone.

## Variables

- `X_train`, `Y_train`, `sub_train`, `X_test`, `Y_test`, `sub_test`, `features`, and `labels`<br>
From the source data<br>
- `merged`<br>
All of the above data are merged<br>
- `merged_summarized`<br>
The average of each variable is summarized by each activity and each subject. `merge_sumarized` is saved as `project_submission.csv`.