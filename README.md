#Readme.md: information about the analysis files
##Introduction
In the following steps, I'll explain what the different steps of the `run_analysis.r` file. The different headers are the same as the explanations used in the code. It's done in two steps, first preparing the `test` and `train` parts, then merging them into one set.
###Get the data
Opens all the required files at once, and assigns them to tablenames that make sense, using `read.table`
#Let's start with the 'test'-data
###column names
###name columns
Assign the names in `X-test`to the columns
###select columns with means and SD's
With `extract_columnNames <- grepl("mean|std", columnNames)` a logical vector is created, that is used by `[,extract_columnNames]` in the next line to select the columns with `mean` or `std` in it.
###activities
Then, we're loading the file `activity_labels.txt` to provide labels for `y_test`
###Cbind test
And using `cbind`we're glueing the whole test-part together.
#and now all the same for the 'train'-data:
###Extract only the measurements on the mean and standard deviation for each measurement.
Using the `extract_columnNames`
###Load activity data
Using `activity_labels.txt`again to provide the correct labels
###Cbind train
Finishing the `train` part by binding the columns.
###Merge test and train data
First putting everything in place, using `rbind`. Then the proper labels are applied. Then the tables are merged, using `melt()`
###Apply mean function to dataset using dcast function
`dcast()` is used, using the right attributes to apply mean on `melt_data`

`write.table()`, to conclude with, saves the new table to `tidy_data.txt`
