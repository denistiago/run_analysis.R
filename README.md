## run_analysis.R
### Required Data
The zipped data used for this assignment is provided [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The original source of the data is the *Human Activity Recognition Using Smartphones Data Set*. It can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


### Script Overview
#### Goal
The goal of the *run_analysis.R* script is to accomplish the following. 

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### Procedure
1. Read data from raw text files into data frames (data assumed to be downloaded prior to script execution)
2. Merge test and train subject data.
3. Merge test and train y data. Merge resulting y data with activity labels.
4. Merge test and train x data. Apply feature data as feature names.
5. Combine merged subject, x and y data (results from 2,3,4).
6. Subset to only mean & stdv features.
7. Compute means grouped by subject and activity.
8. Write results to the FinalData.txt file.