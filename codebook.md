# Introduction


# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` are the datasets from the downloaded zip file.
* `x_data`, `y_data` and `subject_data` are used to combine the data.
* `features` contains the names for the `x_data` dataset, which are applied to the column names stored in `mean_std_features` is the new dataset for which only the relevant mean and standard deviation columns are used.
* A similar approach is taken with activity names through the `activities` variable.
* `tidy_data` merges `x_data`, `y_data` and `subject_data` in one dataset.
* Finally, `avg_data` contains means for the subject and activity groups.