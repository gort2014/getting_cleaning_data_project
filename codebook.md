## Codebook for Getting and Cleaning Data Class Project

#Section One: Summary
This codebook is a data dictionary for the tidy dataset created and uploaded according to the directions for this assignment. The raw data for the tidy dataset 
is from the UC Irvine Machine Learning Repository collection titled Human Activity Recognition Using Smartphones Data Set. See link [here] 
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for more information on the raw dataset.



# Notes on units
column "subject"  identifies the subject in the {subject, activity} pair. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

# Columns
"tBodyAcc-mean-X"           "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z"          
"tGravityAcc-mean-X"        "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"       
"tBodyAccJerk-mean-X"       "tBodyAccJerk-mean-Y"       "tBodyAccJerk-mean-Z"      
"tBodyGyro-mean-X"          "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"         
"tBodyGyroJerk-mean-X"      "tBodyGyroJerk-mean-Y"      "tBodyGyroJerk-mean-Z"     
"fBodyAcc-mean-X"           "fBodyAcc-mean-Y"           "fBodyAcc-mean-Z"
"fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"       "fBodyAccJerk-mean-Z"
"fBodyGyro-mean-X"          "fBodyGyro-mean-Y"          "fBodyGyro-mean-Z" 
"tBodyAccMag-mean"          "tGravityAccMag-mean"       "tBodyAccJerkMag-mean"     
"tBodyGyroMag-mean"         "tBodyGyroJerkMag-mean"      "fBodyAccMag-mean"         
"fBodyBodyAccJerkMag-mean"  "fBodyBodyGyroMag-mean"     "fBodyBodyGyroJerkMag-mean"


"tBodyAcc-std-X"           "tBodyAcc-std-Y"           "tBodyAcc-std-Z"          
"tGravityAcc-std-X"        "tGravityAcc-std-Y"        "tGravityAcc-std-Z"       
"tBodyAccJerk-std-X"       "tBodyAccJerk-std-Y"       "tBodyAccJerk-std-Z"      
"tBodyGyro-std-X"          "tBodyGyro-std-Y"          "tBodyGyro-std-Z"         
"tBodyGyroJerk-std-X"      "tBodyGyroJerk-std-Y"      "tBodyGyroJerk-std-Z"     
"fBodyAcc-std-X"           "fBodyAcc-std-Y"           "fBodyAcc-std-Z"           
"fBodyAccJerk-std-X"       "fBodyAccJerk-std-Y"       "fBodyAccJerk-std-Z"
"fBodyGyro-std-X"          "fBodyGyro-std-Y"          "fBodyGyro-std-Z"
"tBodyAccMag-std"          "tGravityAccMag-std"       "tBodyAccJerkMag-std"     
"tBodyGyroMag-std"         "tBodyGyroJerkMag-std"     "fBodyAccMag-std"         
"fBodyBodyAccJerkMag-std"  "fBodyBodyGyroMag-std"     "fBodyBodyGyroJerkMag-std"