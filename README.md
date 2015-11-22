# Readme.md contains description of building tidy data set from raw data 

## Section One: Quick Summary

The raw data for the tidy dataset is from the UC Irvine Machine Learning Repository collection titled "Human Activity Recognition Using Smartphones Data Set". For more information on the raw dataset see link [here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

This readme file describes a high-level outline of the assumptions and steps used in run_analysis.R. This follows the assignment instructions, e.g. see [this link] (https://class.coursera.org/getdata-034/forum/thread?thread_id=157#comment-286)

For information on modifying the raw data to create the derived dataset in Tidy Data format, a description of the intution of the variables and a data dictionary, please see the codebook.md file in the same GIT repository as this readme file. This readme doesn't duplicate the codebook.md. 

## Section Two: Assumptions

The script run_analysis.R assumes the user has the following folders and files:

- In a folder ..\\UCI HAR Dataset\\train\\..
- x_train.txt contains the training data on the 561-element statistic vectors calculated on the raw data  
- y_train.txt contains the activity codes for the training data
- subject_train.txt contains the subject id for the training data


- In a folder ..\\UCI HAR Dataset\\test\\..
- x_test.txt contains the test data on the 561-element statistic vectors calculated on the raw data  
- y_test.txt contains the test codes for the test data
- subject_test.txt contains the subject id for the test data


- In a folder ..\\UCI HAR Dataset\\..
- activity_labels.txt contains descriptive names for the activities in y_train.txt and y_test.txt
- features.txt has the column names for the files x_train.txt and x_test.txt

- The script assumes the user has installed the package "stringr"

## Section Three: Outline of Steps

- Note: as stated above see codebook.md for more details

- merge training datasets into one file using cbind()

- merge test datasets into one file using cbind()

- combine training and test datasets into one merged file since the interpretation of the columns are the same in both the training and test files, combine the two into one merged file using rbind()

- We need to pick the columns of df_dataCombined that relate to a mean or stDev 

- one way to do this is to pull in the features.txt file which has the column names

- features.txt indicates any column with substring ("-mean()") relates to a mean

- likewise features.txt indicates any column substring ("-std()") relates to a stdDev

-  use grep("-mean()") to return an index to columns in features.txt referring to means (note we have to deal with and remove several named "meanFreq()"" which is a different summary statistic than mean())

-  use grep("-std()") to return an index to columns referring to standard deviations


-  subset the combined dataframe using the column indices we created above & don't forget to prepend the columns for "subject" and "activity"

- for intuitively labeling activity type  I will use the names in the file activity_labels.txt

- I will replace the numeric values of the data in the activity column with a factor variable with levels = names in activity_labels.txt

-  use "labels" argument of function factor() to assign intuitive labels to activities

- appropriately label the data set with descriptive variable names. 

- first grab the raw names from the features.txt file

-  a lot of work has gone into making the variablenames but we can at least clean things up a bit

- use function str_split_fixed() from package "stringr" to split up the column 
 names by the symbols we want to remove, for example the "()" substring

- removing the parentheses from the variable names, i.e. removing the  "()" characters
 
-  search and replace "Acc" with "Accelerometer"

-  search and replace "Gyro" with "Gyroscope"

-  search and replace "-" with "."

-  create a second, independent tidy data set with the average of each variable 
 for each {subject, activity} pairing

- create and index of {subject, activity} pairings per the assignment
 there will be 30 subjects x 6 activities = 180 pairings

-  use aggregate() function to apply average of each column by the 180
 {subject, activity} pairing groups across alll columns
