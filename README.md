# Processing-UCI-HAR-dataset
Loads and processes the UCI HAR Dataset and creates tidy data set according to instructions in Coursera course Getting and Cleaning Data

## Overview

The script, "run_analysis.R", performs the following operations on the UCI HAR dataset:


- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- Extracts only the columns related to mean and standard deviation for each measurement. 
- Merges the training and the test sets to create one data set.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data source and description
- The data was obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Additional information on the dataset is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Code book for run_analysis.R

- xtrain: main training data (data frame table)
- ytrain: activity numbers for training data, script merges this data with xtrain (data frame table)
- xtest: main test data (data frame table)
- ytest: activity numbers for test data, script merges this data with xtest (data frame table)
- sub_train: subject numbers for training data records, script merges this data with xtrain (data frame table)
- sub_test: subject numbers for test data records, script merges this data with xtest (data frame table)
- activity_labs: numeric and text descriptions of activities, script merges this data to combined_dat (data frame)
- combined_dat: training and test data combined in one table, train data first, then test (data frame)
- clean_cols: list used to clean up column headings in combined_dat, "-" and "()" are removed from combined_dat original headings (character vector)
- summary_dat: combined_dat, grouped by activity and subject, and then summarized by mean of each subject (data frame)
