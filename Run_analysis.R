# This script reads the UCI HAR Dataset
# It assumes the data has already been downloaded and
# the working directory is set to the 'UCI HAR Dataset' folder
# The data can be obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Additional information on the dataset is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


library(dplyr)

#Reading in training and test data as tbl_df
xtrain <- tbl_df(read.table("train/X_train.txt"))
ytrain <- tbl_df(read.table("train/y_train.txt"))
xtest <- tbl_df(read.table("test/X_test.txt"))
ytest <- tbl_df(read.table("test/y_test.txt"))
sub_train <- tbl_df(read.table("train/subject_train.txt"))
sub_test <- tbl_df(read.table("test/subject_test.txt"))

#reading in descriptive labels for activities
activity_labs <- read.table("activity_labels.txt")

# THE FOLLOWING SECTION LABELS THE TRAINING AND TEST DATA SETS

#apply labels for test and train data and activity descriptions
col_labs <- read.table("features.txt")
colnames(xtrain) <- col_labs$V2
colnames(xtest) <- col_labs$V2
colnames(activity_labs) <- c("act", "activity") # label "act" is for activity number, "activity" is for activity text description

#name subject and activity column headings
colnames(ytrain) <- "act" #note "act" is for activity number, "activity" is for activity description
colnames(ytest) <- "act"
colnames(sub_train) <- "subject"
colnames(sub_test) <- "subject"


#FOLLOWING SECTION ADDS ACTIVITY AND SUBJECT COLUMNS TO TRAIN AND TEST DATA TABLES

# add activity column to main data
xtrain <- cbind(ytrain,xtrain)
xtest <- cbind(ytest,xtest)

# add subject column to main data
xtrain <- cbind(sub_train,xtrain)
xtest <- cbind(sub_test,xtest)

#SELECTING DESIRED COLUMNS

# only select columns containing the text mean, std, subject, or activity
# note - it was assumed the assignment only required variables (columns) with
# mean or standard deviation attributes to be selected, hence row mean and standard deviation were not calculated
xtest <- xtest[ , grepl("mean|std|subject|act", names(xtest) ) ]
xtrain <- xtrain[ , grepl("mean|std|subject|act", names(xtrain) ) ]


# COMBING TEST AND TRAIN DATA
combined_dat <- rbind(xtrain,xtest)

# This step cleans unwanted characters from column headings
clean_cols <- gsub("-", "", colnames(combined_dat))
clean_cols <- gsub("\\(|\\)", "", clean_cols)
colnames(combined_dat) <- clean_cols

#switch numbered activity labels with descriptive labels
combined_dat <- merge(combined_dat, activity_labs, by.x="act", by.y="act", all = TRUE)

#creating a tidy data set summarizing data based on activity and subject
summary_dat <- combined_dat %>% group_by(activity, subject) %>% summarise_each(funs(mean))


#writing output file for submission to Coursera website
write.table(summary_dat, "Stevenson_tidy_data_submission.txt", row.name=FALSE)
