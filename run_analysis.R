## load R packages used in the script below
library(stringr) ## this package is really great for string manipulation

## set user specific path to out datasets, i.e. the path on your computer
myPath <- "C:\\andyXP\\learnings\\coursera_getData\\UCI HAR Dataset\\"

###############################################################################
###############################################################################
## Beginning step one of assignment
## Merges the training and the test sets to create one data set.

## open training datasets
targetFile <- paste(myPath,"\\train\\X_train.txt", sep="")
df_x_train <- read.table(targetFile,sep = "")
head(df_x_train)
dim(df_x_train)

targetFile <- paste(myPath,"\\train\\y_train.txt", sep="")
df_y_train <- read.table(targetFile,sep = "")
head(df_y_train)
dim(df_y_train)

targetFile <- paste(myPath,"\\train\\subject_train.txt", sep="")
df_subject_train <- read.table(targetFile,sep = "")
head(df_subject_train)
dim(df_subject_train)

## merge training datasets into one file using cbind()
df_training <- cbind(df_x_train,df_y_train,df_subject_train)
head(df_training)
dim(df_training)

# > dim(df_training)
# [1] 7352  563

## keep track of which column is subject and which is activity
colSubject <- 563
colActivity <- 562



## open test datasets
targetFile <- paste(myPath,"\\test\\X_test.txt", sep="")
df_x_test <- read.table(targetFile,sep = "")
head(df_x_test)
dim(df_x_test)

targetFile <- paste(myPath,"\\test\\y_test.txt", sep="")
df_y_test <- read.table(targetFile,sep = "")
head(df_y_test)
dim(df_y_test)

targetFile <- paste(myPath,"\\test\\subject_test.txt", sep="")
df_subject_test <- read.table(targetFile,sep = "")
head(df_subject_test)
dim(df_subject_test)

## merge test datasets into one file using cbind()
df_test <- cbind(df_x_test,df_y_test,df_subject_test)
head(df_test)
dim(df_test)

# > dim(df_test)
# [1] 2947  563

## combine training and test datasets into one merged file
## since the interpretation of the columns are the same in both the training and 
## test files, combine the two into one merged file using rbind()

df_dataCombined <- rbind(df_training,df_test)
head(df_dataCombined)
dim(df_dataCombined)

# > dim(df_dataCombined)
# [1] 10299   563

###############################################################################
###############################################################################
## Beginning step two of assignment
## Extracts only the measurements on the mean and standard deviation for each 
## measurement
##
##
# We need to pick the columns of df_dataCombined that relate to a mean or stDev
## one way to do this is to pull in the features.txt file which has the column names
## features.txt indicates any column with substring ("-mean()") relates to a mean
## likewise features.txt indicates any column substring ("-std()") relates to a stdDev
##
## note: see debugging code at bottom of this script (commented out) that deals with
## figuring out why we have 46 columns with the substring "-mean()" and 33 columns with
## substring "-std()"

## open features.txt wwhich contains column names for x_train and x_test
targetFile <- paste(myPath,"\\features.txt", sep="")
df_features <- read.table(targetFile,sep = "")
df_features[,2]<- as.character(df_features[,2])
head(df_features)
dim(df_features)

## use grep() to return an index to columns in features.txt referring to "mean()"
colIndices_means <- grep("-mean()",df_features[,2])
length(colIndices_means)
df_features[colIndices_means,2] ## review the vector of names referring to means

## use grep() to return an index to columns referring to "meanFreq()" 
## WE DON'T WANT THESE ROWS
## USE THIS INDEX TO REMOVE THEM
colIndices_meansFreq <- grep("-meanFreq()",df_features[,2])
length(colIndices_meansFreq)
df_features[colIndices_meansFreq,2] ## review the vector of names referring to means

## remove the meanFreq() columns to just leave the mean() columns
colIndices_means <- colIndices_means [ !colIndices_means %in% colIndices_meansFreq ]
length(colIndices_means)

## use grep() to return an index to columns referring to standard deviations
colIndices_stdDev <- grep("-std()",df_features[,2])
length(colIndices_stdDev) 
df_features[colIndices_stdDev,2] ## review the vector of names referring to stdDevs

dfTemp <- data.frame(x = df_features[colIndices_stdDev,2])
## subset the combined dataframe using the column indices we created above
## don't forget to prepend the columns for "subject" and "activity"
df_dataSubset <- df_dataCombined[,c(colSubject,colActivity,colIndices_means,colIndices_stdDev)]
dim(df_dataSubset)
head(df_dataSubset)
str(df_dataSubset)
##edit(df_dataSubset)
###############################################################################
###############################################################################
## Beginning step three of assignment
## Uses descriptive activity names to name the activities in the data set
##
## here I will use the names in the file activity_labels.txt
## I will replace the numeric values of the data in the activity column with a
## factor variable with levels = names in activity_labels.txt


## open activity_labels.txt
myPath <- "C:\\andyXP\\learnings\\coursera_getData\\UCI HAR Dataset\\"
targetFile <- paste(myPath,"\\activity_labels.txt", sep="")
activityLabels <- read.table(targetFile,sep = "")
head(activityLabels)
dim(activityLabels)

## use "labels" argument of function factor() to assign intuitive labels to activities
df_dataSubset[,2]<- factor(df_dataSubset[,2],levels = c("1","2","3","4","5","6"), 
                           labels = activityLabels[,2])
head(df_dataSubset[,1:2])
tail(df_dataSubset[,1:2])

###############################################################################
###############################################################################
## Beginning step four of assignment
## Appropriately labels the data set with descriptive variable names. 
##
## first grab the raw names from the features.txt file
columnLabels_means_raw <- df_features[ colIndices_means, 2]
columnLabels_stDevs_raw <- df_features[ colIndices_stdDev, 2]

## a lot of work has gone into making the variable  names
## but we can at least clean things up a bit by removing the parentheses from 
## the variable names, i.e. removing the  "()" characters
## use function str_split_fixed() from package "stringr" to split up the column 
## names by the "()" substring

columnLabels_means_raw_split <- str_split_fixed(columnLabels_means_raw, fixed("()"), n = 2)
columnLabels_means_adjusted <- paste(columnLabels_means_raw_split[,1],
                                     columnLabels_means_raw_split[,2], sep = "")

columnLabels_stDevs_raw_split <- str_split_fixed(columnLabels_stDevs_raw, fixed("()"), n = 2)
columnLabels_stDevs_adjusted <- paste(columnLabels_stDevs_raw_split[,1],
                                     columnLabels_stDevs_raw_split[,2], sep = "")



## concatenate names for mean columns and standard devistion columns
myColumnNames <- c(columnLabels_means_adjusted, columnLabels_stDevs_adjusted)

## add on columns for "subject" and "activity"
myColumnNames <- c("subject","activity", myColumnNames)

## search and replace "Acc" with "Accelerometer"
myColumnNames <- sub(x = myColumnNames,pattern = "Acc", replacement = "Accelerometer")

## search and replace "Gyro" with "Gyroscope"
myColumnNames <- sub(x = myColumnNames,pattern = "Gyro", replacement = "Gyroscope")

## search and replace "-" with "."
myColumnNames <- gsub(x = myColumnNames,pattern = "-", replacement = ".",fixed = TRUE)

## apply the names to the dataset using the names() function
names(df_dataSubset) <- myColumnNames
head(df_dataSubset)
edit(df_dataSubset)

object.size(df_dataSubset)

###############################################################################
###############################################################################
## Beginning step five of assignment
## creates a second, independent tidy data set with the average of each variable 
## for each {subject, activity} pairing

## create and index of {subject, activity} pairings per the assignment
## there will be 30 subjects x 6 activities = 180 pairings
table(df_dataSubset$subject,df_dataSubset$activity)
myGroups <- paste(df_dataSubset$subject, "_", df_dataSubset$activity, sep="")

## use aggregate() function to apply average of each column by the 180
## {subject, activity} pairing groups

## temporarily transform factor column "activity" into its underlying numeric value so we
## because the factor variable will be set to NA by the mean() function
df_dataSubset[,2] <-unclass(df_dataSubset[,2])
                         
df_dataFinal <-aggregate(df_dataSubset,
                by = list(myGroups), mean)

dim(df_dataFinal)
# > dim(df_dataFinal)
# [1] 180  69

## remove the "group" column as it can be easily derived by concatenating cols 1 & 2
df_dataFinal <- df_dataFinal[,-1]

dim(df_dataFinal)
# > dim(df_dataFinal)
# [1] 180  68

## add back the intuitive factor levels for the activity column now that we have 
## taken averages
## NOTE: PLUGGING THESE BACK IN LEAVES SATISFIES PROVIDING AVERAGES IN EACH COLUMN
## THIS IS BECAUSE THERE IS ONLY ONE UNIQUE FACTOR PER SUBJECT,ACTIVITY PAIR, SO THE
## FACTOR LEVEL EQUALS THE AVERAGE FACTOR LEVEL FOPR EACH ROW!!!
df_dataFinal[,2]<- factor(df_dataFinal[,2],levels = c("1","2","3","4","5","6"), 
                           labels = activityLabels[,2])

edit(df_dataFinal)

## now write the resulting tidy dataset to a text file
myPath <- "C:\\andyXP\\learnings\\coursera_getData\\"
targetFile <- paste(myPath,"my_tidy_data.txt", sep="")
write.table(df_dataFinal,file = targetFile,sep = "\t",row.name = FALSE)


## test the write.table() by importing back in
myPath <- "C:\\andyXP\\learnings\\coursera_getData\\"
targetFile <- paste(myPath,"my_tidy_data.txt", sep="")
testMyFile<-read.table(file = targetFile,sep = "\t",header = TRUE)
dim(testMyFile)
dfTemp <- data.frame(x=names(testMyFile))
edit(dfTemp)
edit(testMyFile)

## OPTIONAL: RUN SOME GRAPHICS TO REVIEW THE DATA
par(mfrow = c(2,2))

hist(testMyFile$tBodyAccelerometer.mean.X)
hist(testMyFile$tBodyAccelerometer.mean.Y)
hist(testMyFile$tBodyAccelerometer.mean.Z)


################################################################################
################################################################################
## debugging code

## why do we get 46 rows related to means and 33 rows related to stdDevs???
## use function str_split_fixed() from package "stringr" to split up the column 
## names into {variable name, type of mean, x-y-z coordinate}
## we can look for duplicates and other problems

#str_split_fixed(df_features[colIndices_means,2], "-", n = 3)

## the function above shows that when we grep() on the string "mean" we get two
## different types of calculation types, mean() and "meanFreq()"
## we don't want the "meanFreq()"


