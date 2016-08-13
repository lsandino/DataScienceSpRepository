# Getting and Cleaning Data Course Project

## File: run_analysis.md
### Author: Luis Sandino

***

Created on 2016-01-23 04:09:39 using R version 3.2.3 (2015-12-10)

***

## 0. Read all the data

Set path to original data set folder and list files in it

```r
path.wd <- getwd()
path.data <- file.path(path.wd,"UCI_HAR_Dataset")
list.files(path.data, recursive = TRUE)
```

```
##  [1] "activity_labels.txt"                         
##  [2] "features.txt"                                
##  [3] "features_info.txt"                           
##  [4] "README.txt"                                  
##  [5] "test/Inertial Signals/body_acc_x_test.txt"   
##  [6] "test/Inertial Signals/body_acc_y_test.txt"   
##  [7] "test/Inertial Signals/body_acc_z_test.txt"   
##  [8] "test/Inertial Signals/body_gyro_x_test.txt"  
##  [9] "test/Inertial Signals/body_gyro_y_test.txt"  
## [10] "test/Inertial Signals/body_gyro_z_test.txt"  
## [11] "test/Inertial Signals/total_acc_x_test.txt"  
## [12] "test/Inertial Signals/total_acc_y_test.txt"  
## [13] "test/Inertial Signals/total_acc_z_test.txt"  
## [14] "test/subject_test.txt"                       
## [15] "test/X_test.txt"                             
## [16] "test/y_test.txt"                             
## [17] "train/Inertial Signals/body_acc_x_train.txt" 
## [18] "train/Inertial Signals/body_acc_y_train.txt" 
## [19] "train/Inertial Signals/body_acc_z_train.txt" 
## [20] "train/Inertial Signals/body_gyro_x_train.txt"
## [21] "train/Inertial Signals/body_gyro_y_train.txt"
## [22] "train/Inertial Signals/body_gyro_z_train.txt"
## [23] "train/Inertial Signals/total_acc_x_train.txt"
## [24] "train/Inertial Signals/total_acc_y_train.txt"
## [25] "train/Inertial Signals/total_acc_z_train.txt"
## [26] "train/subject_train.txt"                     
## [27] "train/X_train.txt"                           
## [28] "train/y_train.txt"
```
Read subject IDs

```r
trainSubjectIDs <- read.table(file.path(path.data,"train","subject_train.txt"))
testSubjectIDs <- read.table(file.path(path.data,"test","subject_test.txt"))
```
Read activity IDs

```r
trainActivityIDs <- read.table(file.path(path.data,"train","y_train.txt"))
testActivityIDs <- read.table(file.path(path.data,"test","y_test.txt"))
```
Read data sets

```r
trainDataset <- read.table(file.path(path.data,"train","X_train.txt"))
testDataset <- read.table(file.path(path.data,"test","X_test.txt"))
```

## 1. Merge the training and the test sets to create one data set


```r
dataset <- cbind(rbind(testSubjectIDs,trainSubjectIDs),rbind(testActivityIDs,trainActivityIDs),rbind(testDataset,trainDataset))
```

## 2. Extract only the measurements on the mean and standard deviation for each measurement

Read Variable names

```r
VariableNames <- read.table(file.path(path.data,"features.txt"))
```
Search for mean() and std() in variable names table

```r
meanVect <- grep("mean\\(\\)",VariableNames[,2])
stdVect <- grep("std\\(\\)",VariableNames[,2])
```
Extract the data from the merged data set

```r
dataset <- dataset[,sort(c(1,2,meanVect+2,stdVect+2))]
```

## 3. Uses descriptive activity names to name the activities in the data set

Read Activity names

```r
ActivityNames <- read.table(file.path(path.data,"activity_labels.txt"))
```
Match the names in the table with the IDs in the data set

```r
dataset[,2] <- ActivityNames[,2][dataset[,2]]
```

## 4. Appropriately label the data set with descriptive variable names

Parse Variable names vector

```r
VariableNamesVect <- as.character(VariableNames[sort(c(meanVect,stdVect)),2])
VariableNamesVect <- sub("^t","time.",VariableNamesVect)
VariableNamesVect <- sub("^f","freq.",VariableNamesVect)
VariableNamesVect <- sub("-mean\\(\\)",".mean",VariableNamesVect)
VariableNamesVect <- sub("-std\\(\\)",".std",VariableNamesVect)
VariableNamesVect <- sub("-X",".X",VariableNamesVect)
VariableNamesVect <- sub("-Y",".Y",VariableNamesVect)
VariableNamesVect <- sub("-Z",".Z",VariableNamesVect)
VariableNamesVect <- sub("mean.X","X.mean",VariableNamesVect)
VariableNamesVect <- sub("mean.Y","Y.mean",VariableNamesVect)
VariableNamesVect <- sub("mean.Z","Z.mean",VariableNamesVect)
VariableNamesVect <- sub("std.X","X.std",VariableNamesVect)
VariableNamesVect <- sub("std.Y","Y.std",VariableNamesVect)
VariableNamesVect <- sub("std.Z","Z.std",VariableNamesVect)
```
Set new names

```r
colnames(dataset) <- c("Subject.ID","Activity.Name",VariableNamesVect)
```

## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

Order data by Subject and Activity, convert to data frame and make groups

```r
tidyDataset <- group_by(data.frame(arrange(dataset,Subject.ID,Activity.Name)),Subject.ID,Activity.Name)
```
Calculate the average of each variable for each group

```r
tidyDataset <- summarize_each(tidyDataset,funs(mean))
```
Save tidy Dataset to text file

```r
write.table(tidyDataset,file="tidyDataset.txt",row.name=FALSE)
```
