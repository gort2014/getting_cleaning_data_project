# Codebook for Getting and Cleaning Data Class Project

## Section One: Quick Summary
This codebook describes the process of creating the tidy dataset created and uploaded according to the directions for this assignment. It describes the source data and provides information on modifying the raw data to create the derived dataset in Tidy Data format, with a focus on the R script used to conduct the modifications. It also includes a description of the intution of the variables and a data dictionary of the final, modified output. The original raw data is from the UC Irvine Machine Learning Repository collection titled "Human Activity Recognition Using Smartphones Data Set". For more information on the raw dataset see link [here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

## Section Two: Modifying the Raw Data to Create the Tidy Data

Files used:
- x_train.txt contains the training data on the 561-element statistic vectors calculated on the raw data  
- y_train.txt contains the activity codes for the training data
- subject_train.txt contains the subject id for the training data
- x_test.txt contains the test data on the 561-element statistic vectors calculated on the raw data  
- y_test.txt contains the test codes for the test data
- subject_test.txt contains the subject id for the test data
- activity_labels.txt contains descriptive names for the activities in y_train.txt and y_test.txt
- features.txt has the column names for the files x_train.txt and x_test.txt

Script used
- The following details are implemented in the R script run_analysis.R, stored in the same GIT repository as this codebook.
 
Step 1: Merges the training and the test sets to create one data set 
- start with the traing data sets
- Assemble the training files x_train.txt, y_train.txt and subject_train.txt into one training dataset
- start by looking at dimenions of files. Use the dimensions of the files along with an understanding of what the data represents to decide how to properly merge.
- dimensions of x_train.txt is 7352 x 561 
- dimensions of y_train.txt is  7352 x 1
- dimensions of subject_train.txt is  7352 x 1
- Since all three training data files have the same number of rows, we start merging by columns using cbind() into one training data file
- The resulting file will have dimension of 7352 x 563 

Now do the same for the test datasets 
- Assemble the test files x_test.txt, y_test.txt and subject_test.txt into one test dataset
- dimensions of x_test.txt are 2947 x 561 
- dimensions of y_test.txt are  2947 x 1
- dimensions of subject_test.txt are  2947 x 1
- Since all three test data files have the same number of rows, we start merging by columns using cbind() into one test data file
- The resulting file will have dimension of 7352 x 563 

Combining training and test datasets into one merged file
- since the interpretation of the columns are the same in both the training and test files, combine the two into one merged file using rbind()
- the resulting combined file has dimensions of 10299 x 563

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
- the task is to find out which of the 563 columns relate to mean and standard deviation
- the file features.txt contains all the column names
- run a grep() on the features.txt to find the columns related to mean and std 
- grep("-mean()") and grep("-std()") in order to get a vector of column indices
- use the column indices to subset the combined dataframe

Step 3: Uses descriptive activity names to name the activities in the data set
- use the descriptive names in the activity_labels.txt file
- Modify the activity column of the dataset as a six-level factor variable with level labels in the following set: 
{WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING} 

Step 4: Appropriately label the data set with descriptive variable names.   
- this is effectively asking to improve on the variable names in the features.txt file. Give it a shot!

- According the the principles of tidy data, I have changed the labels in the raw data to make them more readable. I changed the names for the columns representing variables related to acceleration to contain the substring "Accelerometer". The units for all of these columns are in standard gravity units 'g'. I have labeled the columns representing variables related to angular velocity so that the label contains the substring "Gyroscope". The units for all of these columns are in radians/second. Note: See the appendix below for a mapping between my intuitive naming conventions used to create a tidy dataset and the original column names used in the documetation at the link above.

section 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
- To quote from the assignment, the dataset must contain "the average of each variable for each activity and each subject," where the average and standard deviations are calculated from the raw dataset. As such, each row in the tidy dataset represents a unique {subject, activity} pair. There are 30 unique subjects and 6 unique activties, therefore there are 30 x 6 = 180 unique rows representing the unique {subject, activity} pairs.	

- Grouping by the 180 unique {subject, activity} pairs, calculate the mean and standard deviation of each of the 68 columns (66 columns with variable measurements on mean and standard deviation plus the subject column and the activity column). This is the final dataset

## Section Three: Interpretation of Variables in Dataset

- The first column "subject"  identifies the subject in the {subject, activity} pair. Its range is from 1 to 30. 

- The second column contains the "activity" types. I coded this as a six-level factor variable with level labels in the following set: 
{WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING}

- The remaining columns of this file represent summary statistics in the form of means and standard deviations of the raw data, for each {subject, activity} pair. The descriptions of the raw data are technical and very well described in the documentation at the link to the raw data provided above. This codebook will not duplicate all the technical details here. Instead the codebook provides a very brief summary of the intuition about the measurement variables in the columns of this tidy dataset to help with reading the data dictionary below.

- Briefly, the summary statistics in the columns of this dataset (the columns other than subject and activity) contain means and standard deviations for 33 different measurements of human activity as tracked by an accelerometer and gyroscope in a smartphone carried by the subjects during activity. (There are 33 mean columns and 33 standard deviation columns.) The accelerometer provides data on different measures of acceleration during the time of the activity (3-axial linear acceleration) and the gyroscope provides data on different measures of angular velocity during the time of the activity (3-axial angular velocity). As a quick note, because all the measurements included in this dataset come from either an accelerometer or a gyroscope, there are only two types of units used in this data. These are standard gravity units 'g' for accelerometer data columns and radians/second for the gyroscope data columns.


## Section Four: Data Dictionary
Below I list each of the columns followed by a short definition. As described above, this is a small file of summary statistics on means and standard deviations derived from raw data obtained from the UC Irvine Machine Learning Repository collection titled "Human Activity Recognition Using Smartphones Data Set". For more details on any column see see detailed explanations provided at [this link] 
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). See appendix below for a mapping between my intuitive naming conventions used to create a tidy dataset and the original column names used in the documetation at the link above.

Key to variable naming convention:
variables are a concatenation of the following terms: 
[domain][force][measurement device][measurement type].[summary statistic][axis]

[domain] in {t,d} where t = time domain and f = frequency domain

[force] in {body, gravity} where acceleration is decomposed into the two 

[measurement device] in {Accelerometer,Gyroscope}

[measurement type] in {Jerk, Mag, JerkMag, blank} where Jerk is derivative of measurement, mag is magnitude and JerkMag is magnitude of jerk. 

[summary statistic] in {mean,std} where mean is average and std is standard deviation
[axis] in {x,y,z} representing 3-d coordinate space 

Column #                      Label 	Description

1                             subject	ID for subjects. Integer from 1-30 

2                            activity	Factor variable for Activity type. oded this as a six-level factor variable with level lables in the following set: 
										{WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING}

3           *tBodyAccelerometer.mean.X*	= Mean acceleration, body motion, x-axis. See Footnote A for units
  
4           *tBodyAccelerometer.mean.Y*	= Mean acceleration, body motion, y-axis. See footnote A for units 

5           *tBodyAccelerometer.mean.Z*	= Mean acceleration, body motion, z-axis. See footnote A for units    

6        *tGravityAccelerometer.mean.X*	= Mean acceleration, gravity motion, x-axis. See footnote A for units

7        *tGravityAccelerometer.mean.Y*	= Mean acceleration, gravity motion, y-axis. See footnote A for units

8        *tGravityAccelerometer.mean.Z*	= Mean acceleration, gravity motion, z-axis. See footnote A for units

9       *tBodyAccelerometerJerk.mean.X*	= Mean jerk (derivative of acceleration), body motion, x-axis. See footnote A for units

10      *tBodyAccelerometerJerk.mean.Y*	= Mean jerk (derivative of acceleration), body motion, y-axis. See footnote A for units

11      *tBodyAccelerometerJerk.mean.Z*	= Mean jerk (derivative of acceleration), body motion, z-axis. See footnote A for units

12              *tBodyGyroscope.mean.X*	= Mean angular velocity, body motion, x-axis. See footnote B for units

13              *tBodyGyroscope.mean.Y*	= Mean angular velocity, body motion, y-axis. See footnote B for units

14              *tBodyGyroscope.mean.Z*	= Mean angular velocity, body motion, z-axis. See footnote B for units

15          *tBodyGyroscopeJerk.mean.X*	= Mean jerk (derivative of angular velocity), body motion, x-axis. See footnote B for units

16          *tBodyGyroscopeJerk.mean.Y*	= Mean jerk (derivative of angular velocity), body motion, y-axis. See footnote B for units

17          *tBodyGyroscopeJerk.mean.Z*	= Mean jerk (derivative of angular velocity), body motion, z-axis. See footnote B for units

18         *tBodyAccelerometerMag.mean*	= Mean magnitude of acceleration, body motion. See footnote A for units

19      *tGravityAccelerometerMag.mean*	= Mean magnitude of acceleration, gravity motion. See footnote A for units

20     *tBodyAccelerometerJerkMag.mean*	= Mean magnitude of jerk (derivative of acceleration), body motion. See footnote A for units

21             *tBodyGyroscopeMag.mean*	= Mean magnitude of jerk (derivative of acceleration), body motion. See footnote B for units

22         *tBodyGyroscopeJerkMag.mean*	= Mean magnitude of jerk (derivative of acceleration), body motion. See footnote B for units

23          *fBodyAccelerometer.mean.X*	= Mean acceleration, frequency domain, body motion, x-axis. See footnote A for units

24           *fBodyAccelerometer.mean.Y*	= Mean acceleration, frequency domain, body motion, y-axis. See footnote A for units

25           *fBodyAccelerometer.mean.Z*	= Mean acceleration, frequency domain, body motion, z-axis. See footnote A for units

26       *fBodyAccelerometerJerk.mean.X*	= Mean jerk (derivative of acceleration), frequency domain, body motion, x-axis. See footnote A for units

27       *fBodyAccelerometerJerk.mean.Y*	= Mean jerk (derivative of acceleration), frequency domain, body motion, y-axis. See footnote A for units

28       *fBodyAccelerometerJerk.mean.Z*	= Mean jerk (derivative of acceleration), frequency domain, body motion, z-axis. See footnote A for units

29               *fBodyGyroscope.mean.X*	= Mean angular velocity, body motion, frequency domain, x-axis. See footnote B for units

30               *fBodyGyroscope.mean.Y*	= Mean angular velocity, body motion, frequency domain, y-axis. See footnote B for units

31               *fBodyGyroscope.mean.Z*	= Mean angular velocity, body motion, frequency domain, z-axis. See footnote B for units

32          *fBodyAccelerometerMag.mean*	= Mean magnitude of acceleration, frequency domain, body motion. See footnote A for units

33 fBodyBodyAccelerometerJerkMag.mean*	= Mean magnitude of jerk (derivative of acceleration), frequency domain, body motion. See footnote A for units

34          *fBodyBodyGyroscopeMag.mean*	= Mean magnitude of angular velocity, frequency domain, body motion. See footnote B for units

35      *fBodyBodyGyroscopeJerkMag.mean*	= Mean magnitude jerk (derivative of angular velocity), frequency domain, body motion. See footnote B for units

36           *tBodyAccelerometer.std.X*	= Std deviation acceleration, body motion, x-axis. See Footnote A for units

37           *tBodyAccelerometer.std.Y*	= Std deviation acceleration, body motion, y-axis. See Footnote A for units

38           *tBodyAccelerometer.std.Z*	= Std deviation acceleration, body motion, z-axis. See Footnote A for units

39        *tGravityAccelerometer.std.X*	= Std deviation acceleration, gravity motion, x-axis. See footnote A for units

40        *tGravityAccelerometer.std.Y*	= Std deviation acceleration, gravity motion, y-axis. See footnote A for units

41        *tGravityAccelerometer.std.Z*	= Std deviation acceleration, gravity motion, z-axis. See footnote A for units

42       *tBodyAccelerometerJerk.std.X*	= Std deviation jerk (derivative of acceleration), body motion, x-axis. See footnote A for units

43       *tBodyAccelerometerJerk.std.Y*	= Std deviation jerk (derivative of acceleration), body motion, y-axis. See footnote A for units

44       *tBodyAccelerometerJerk.std.Z*	= Std deviation jerk (derivative of acceleration), body motion, z-axis. See footnote A for units

45               *tBodyGyroscope.std.X*	= Std deviation angular velocity, body motion, x-axis. See footnote B for units

46               *tBodyGyroscope.std.Y*	= Std deviation angular velocity, body motion, y-axis. See footnote B for units

47               *tBodyGyroscope.std.Z*	= Std deviation angular velocity, body motion, z-axis. See footnote B for units

48           *tBodyGyroscopeJerk.std.X*	= Std deviation jerk (derivative of angular velocity), body motion, x-axis. See footnote B for units

49           *tBodyGyroscopeJerk.std.Y*	= Std deviation jerk (derivative of angular velocity), body motion, y-axis. See footnote B for units

50           *tBodyGyroscopeJerk.std.Z*	= Std deviation jerk (derivative of angular velocity), body motion, z-axis. See footnote B for units

51          *tBodyAccelerometerMag.std*	= Std deviation magnitude acceleration, body motion. See footnote A for units

52       *tGravityAccelerometerMag.std*	= Std deviation magnitude acceleration, body motion. See footnote A for units

53      *tBodyAccelerometerJerkMag.std*	= Std deviation magnitude acceleration, body motion. See footnote A for units

54              *tBodyGyroscopeMag.std*	= Std deviation magnitude angular velocity, body motion. See footnote B for units

55          *tBodyGyroscopeJerkMag.std*	= Std deviation magnitude jerk (derivative of angular velocity), body motion. See footnote B for units

56            *fBodyAccelerometer.std.X*	= Std deviation acceleration, frequency domain, body motion, x-axis. See footnote A for units

57            *fBodyAccelerometer.std.Y*	= Std deviation acceleration, frequency domain, body motion, y-axis. See footnote A for units

58            *fBodyAccelerometer.std.Z*	= Std deviation acceleration, frequency domain, body motion, z-axis. See footnote A for units

59        *fBodyAccelerometerJerk.std.X*	= Std deviation jerk (derivative of acceleration), frequency domain, body motion, x-axis. See footnote A for units

60        *fBodyAccelerometerJerk.std.Y*	= Std deviation jerk (derivative of acceleration), frequency domain, body motion, y-axis. See footnote A for units

61        *fBodyAccelerometerJerk.std.Z*	= Std deviation jerk (derivative of acceleration), frequency domain, body motion, z-axis. See footnote A for units

62                *fBodyGyroscope.std.X*	= Std deviation angular velocity, frequency domain, body motion, x-axis. See footnote B for units

63                *fBodyGyroscope.std.Y*	= Std deviation angular velocity, frequency domain, body motion, y-axis. See footnote B for units

64                *fBodyGyroscope.std.Z*	= Std deviation angular velocity, frequency domain, body motion, z-axis. See footnote B for units

65           *fBodyAccelerometerMag.std*	= Std deviation magnitude acceleration, frequency domain, body motion. See footnote A for units

66   *fBodyBodyAccelerometerJerkMag.std*	= Std deviation magnitude jerk (derivative of acceleration), frequency domain, body motion. See footnote A

67           *fBodyBodyGyroscopeMag.std*	= Std deviation magnitude angular velocity, frequency domain, body motion. See footnote B

68       *fBodyBodyGyroscopeJerkMag.std*	= Std deviation magnitude jerk (derivative of angular velocity), frequency domain, body motion. See footnote B

Footnote A - units in standard gravity units 'g', normalized an bounded within interval [-1,1]

Footnote B - units in radians/second, normalized an bounded within interval [-1,1]

Footnote C - Factor variable with levels in {WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING} 

## Appendix: Mappings between my tidy data column labels and the raw data column labels 

my tidy data label                |  raw data label
----------------------------------|-----------------------------------              		
tBodyAccelerometer.mean.X         |		tBodyAcc-mean()-X
tBodyAccelerometer.mean.Y         |		tBodyAcc-mean()-Y
tBodyAccelerometer.mean.Z         |		tBodyAcc-mean()-Z
tGravityAccelerometer.mean.X      |		tGravityAcc-mean()-X
tGravityAccelerometer.mean.Y      |		tGravityAcc-mean()-Y
tGravityAccelerometer.mean.Z      |		tGravityAcc-mean()-Z
tBodyAccelerometerJerk.mean.X     |		tBodyAccJerk-mean()-X
tBodyAccelerometerJerk.mean.Y     |		tBodyAccJerk-mean()-Y
tBodyAccelerometerJerk.mean.Z     |		tBodyAccJerk-mean()-Z
tBodyGyroscope.mean.X             |		tBodyGyro-mean()-X
tBodyGyroscope.mean.Y             |		tBodyGyro-mean()-Y
tBodyGyroscope.mean.Z             |		tBodyGyro-mean()-Z
tBodyGyroscopeJerk.mean.X         |		tBodyGyroJerk-mean()-X
tBodyGyroscopeJerk.mean.Y         |		tBodyGyroJerk-mean()-Y
tBodyGyroscopeJerk.mean.Z         |		tBodyGyroJerk-mean()-Z
tBodyAccelerometerMag.mean        |		tBodyAccMag-mean()
tGravityAccelerometerMag.mean     |		tGravityAccMag-mean()
tBodyAccelerometerJerkMag.mean    |		tBodyAccJerkMag-mean()
tBodyGyroscopeMag.mean            |		tBodyGyroMag-mean()
tBodyGyroscopeJerkMag.mean        |		tBodyGyroJerkMag-mean()
fBodyAccelerometer.mean.X         |		fBodyAcc-mean()-X
fBodyAccelerometer.mean.Y         |		fBodyAcc-mean()-Y
fBodyAccelerometer.mean.Z         |		fBodyAcc-mean()-Z
fBodyAccelerometerJerk.mean.X     |		fBodyAccJerk-mean()-X
fBodyAccelerometerJerk.mean.Y     |		fBodyAccJerk-mean()-Y
fBodyAccelerometerJerk.mean.Z     |		fBodyAccJerk-mean()-Z
fBodyGyroscope.mean.X             |		fBodyGyro-mean()-X
fBodyGyroscope.mean.Y             |		fBodyGyro-mean()-Y
fBodyGyroscope.mean.Z             |		fBodyGyro-mean()-Z
fBodyAccelerometerMag.mean        |		fBodyAccMag-mean()
fBodyBodyAccelerometerJerkMag.mean|		fBodyBodyAccJerkMag-mean()
fBodyBodyGyroscopeMag.mean        |		fBodyBodyGyroMag-mean()
fBodyBodyGyroscopeJerkMag.mean    |		fBodyBodyGyroJerkMag-mean()
tBodyAccelerometer.std.X          |		tBodyAcc-std()-X
tBodyAccelerometer.std.Y          |		tBodyAcc-std()-Y
tBodyAccelerometer.std.Z          |		tBodyAcc-std()-Z
tGravityAccelerometer.std.X       |		tGravityAcc-std()-X
tGravityAccelerometer.std.Y       |		tGravityAcc-std()-Y
tGravityAccelerometer.std.Z       |		tGravityAcc-std()-Z
tBodyAccelerometerJerk.std.X      |		tBodyAccJerk-std()-X
tBodyAccelerometerJerk.std.Y      |		tBodyAccJerk-std()-Y
tBodyAccelerometerJerk.std.Z      |		tBodyAccJerk-std()-Z
tBodyGyroscope.std.X              |		tBodyGyro-std()-X
tBodyGyroscope.std.Y              |		tBodyGyro-std()-Y
tBodyGyroscope.std.Z              |		tBodyGyro-std()-Z
tBodyGyroscopeJerk.std.X          |		tBodyGyroJerk-std()-X
tBodyGyroscopeJerk.std.Y          |		tBodyGyroJerk-std()-Y
tBodyGyroscopeJerk.std.Z          |		tBodyGyroJerk-std()-Z
tBodyAccelerometerMag.std         |		tBodyAccMag-std()
tGravityAccelerometerMag.std      |		tGravityAccMag-std()
tBodyAccelerometerJerkMag.std     |		tBodyAccJerkMag-std()
tBodyGyroscopeMag.std             |		tBodyGyroMag-std()
tBodyGyroscopeJerkMag.std         |		tBodyGyroJerkMag-std()
fBodyAccelerometer.std.X          |		fBodyAcc-std()-X
fBodyAccelerometer.std.Y          |		fBodyAcc-std()-Y
fBodyAccelerometer.std.Z          |		fBodyAcc-std()-Z
fBodyAccelerometerJerk.std.X      |		fBodyAccJerk-std()-X
fBodyAccelerometerJerk.std.Y      |		fBodyAccJerk-std()-Y
fBodyAccelerometerJerk.std.Z      |		fBodyAccJerk-std()-Z
fBodyGyroscope.std.X              |		fBodyGyro-std()-X
fBodyGyroscope.std.Y              |		fBodyGyro-std()-Y
fBodyGyroscope.std.Z              |		fBodyGyro-std()-Z
fBodyAccelerometerMag.std         |		fBodyAccMag-std()
fBodyBodyAccelerometerJerkMag.std |		fBodyBodyAccJerkMag-std()
fBodyBodyGyroscopeMag.std         |		fBodyBodyGyroMag-std()
fBodyBodyGyroscopeJerkMag.std     |		fBodyBodyGyroJerkMag-std()
