# Getting and Cleaning Data Course Project

## File: CodeBook.md
### Author: Luis Sandino

***

Created on 2016-01-23 04:09:58 using R version 3.2.3 (2015-12-10)

***

## Codebook

### Variables description

| Variable name             | Description                                    |
|---------------------------|------------------------------------------------|
| Subject.ID                | ID number of the subject [1-30]                |
| Activity.Name             | Activity name                                  |
| Domain.Feature.Axis.Type (Variables from 3 to 68)| where                   |
|                           | _Domain_ = time OR freq                        |
|                    |_Feature_ = mix of __words__ describing the measurement|
|                           | __Body__ -> acceleration - gravity acceleration|
|                           | __Gravity__ -> total acceleration              |
|                           | __Acc__ -> accelerometer sensor                |
|                           | __Gyro__ -> gyroscope sensor                   |
|                           | __Jerk__ -> jerk signal (from derivation)      |
|                           | __Mag__ -> Euclidean magnitude                 |
|                           | _Axis_ = X, Y OR Z direction                   |
|                           | _Type_ = mean OR std (standard deviation)      |

### Tidy Dataset structure


```r
str(tidyDataset)
```

```
## Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	180 obs. of  68 variables:
##  $ Subject.ID                   : int  1 1 1 1 1 1 2 2 2 2 ...
##  $ Activity.Name                : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...
##  $ time.BodyAcc.X.mean          : num  0.222 0.261 0.279 0.277 0.289 ...
##  $ time.BodyAcc.Y.mean          : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
##  $ time.BodyAcc.Z.mean          : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
##  $ time.BodyAcc.X.std           : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
##  $ time.BodyAcc.Y.std           : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
##  $ time.BodyAcc.Z.std           : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
##  $ time.GravityAcc.X.mean       : num  -0.249 0.832 0.943 0.935 0.932 ...
##  $ time.GravityAcc.Y.mean       : num  0.706 0.204 -0.273 -0.282 -0.267 ...
##  $ time.GravityAcc.Z.mean       : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
##  $ time.GravityAcc.X.std        : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
##  $ time.GravityAcc.Y.std        : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
##  $ time.GravityAcc.Z.std        : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
##  $ time.BodyAccJerk.X.mean      : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
##  $ time.BodyAccJerk.Y.mean      : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
##  $ time.BodyAccJerk.Z.mean      : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
##  $ time.BodyAccJerk.X.std       : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
##  $ time.BodyAccJerk.Y.std       : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
##  $ time.BodyAccJerk.Z.std       : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
##  $ time.BodyGyro.X.mean         : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
##  $ time.BodyGyro.Y.mean         : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
##  $ time.BodyGyro.Z.mean         : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
##  $ time.BodyGyro.X.std          : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
##  $ time.BodyGyro.Y.std          : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
##  $ time.BodyGyro.Z.std          : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
##  $ time.BodyGyroJerk.X.mean     : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
##  $ time.BodyGyroJerk.Y.mean     : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
##  $ time.BodyGyroJerk.Z.mean     : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
##  $ time.BodyGyroJerk.X.std      : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
##  $ time.BodyGyroJerk.Y.std      : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
##  $ time.BodyGyroJerk.Z.std      : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
##  $ time.BodyAccMag.mean         : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
##  $ time.BodyAccMag.std          : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
##  $ time.GravityAccMag.mean      : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
##  $ time.GravityAccMag.std       : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
##  $ time.BodyAccJerkMag.mean     : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
##  $ time.BodyAccJerkMag.std      : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
##  $ time.BodyGyroMag.mean        : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
##  $ time.BodyGyroMag.std         : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
##  $ time.BodyGyroJerkMag.mean    : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
##  $ time.BodyGyroJerkMag.std     : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
##  $ freq.BodyAcc.X.mean          : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
##  $ freq.BodyAcc.Y.mean          : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
##  $ freq.BodyAcc.Z.mean          : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
##  $ freq.BodyAcc.X.std           : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
##  $ freq.BodyAcc.Y.std           : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
##  $ freq.BodyAcc.Z.std           : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
##  $ freq.BodyAccJerk.X.mean      : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
##  $ freq.BodyAccJerk.Y.mean      : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
##  $ freq.BodyAccJerk.Z.mean      : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
##  $ freq.BodyAccJerk.X.std       : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
##  $ freq.BodyAccJerk.Y.std       : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
##  $ freq.BodyAccJerk.Z.std       : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
##  $ freq.BodyGyro.X.mean         : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
##  $ freq.BodyGyro.Y.mean         : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
##  $ freq.BodyGyro.Z.mean         : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
##  $ freq.BodyGyro.X.std          : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
##  $ freq.BodyGyro.Y.std          : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
##  $ freq.BodyGyro.Z.std          : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
##  $ freq.BodyAccMag.mean         : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
##  $ freq.BodyAccMag.std          : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
##  $ freq.BodyBodyAccJerkMag.mean : num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
##  $ freq.BodyBodyAccJerkMag.std  : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
##  $ freq.BodyBodyGyroMag.mean    : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
##  $ freq.BodyBodyGyroMag.std     : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
##  $ freq.BodyBodyGyroJerkMag.mean: num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
##  $ freq.BodyBodyGyroJerkMag.std : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
##  - attr(*, "vars")=List of 1
##   ..$ : symbol Subject.ID
##  - attr(*, "drop")= logi TRUE
```

### Full list of variable names


```r
names(tidyDataset)
```

```
##  [1] "Subject.ID"                    "Activity.Name"                
##  [3] "time.BodyAcc.X.mean"           "time.BodyAcc.Y.mean"          
##  [5] "time.BodyAcc.Z.mean"           "time.BodyAcc.X.std"           
##  [7] "time.BodyAcc.Y.std"            "time.BodyAcc.Z.std"           
##  [9] "time.GravityAcc.X.mean"        "time.GravityAcc.Y.mean"       
## [11] "time.GravityAcc.Z.mean"        "time.GravityAcc.X.std"        
## [13] "time.GravityAcc.Y.std"         "time.GravityAcc.Z.std"        
## [15] "time.BodyAccJerk.X.mean"       "time.BodyAccJerk.Y.mean"      
## [17] "time.BodyAccJerk.Z.mean"       "time.BodyAccJerk.X.std"       
## [19] "time.BodyAccJerk.Y.std"        "time.BodyAccJerk.Z.std"       
## [21] "time.BodyGyro.X.mean"          "time.BodyGyro.Y.mean"         
## [23] "time.BodyGyro.Z.mean"          "time.BodyGyro.X.std"          
## [25] "time.BodyGyro.Y.std"           "time.BodyGyro.Z.std"          
## [27] "time.BodyGyroJerk.X.mean"      "time.BodyGyroJerk.Y.mean"     
## [29] "time.BodyGyroJerk.Z.mean"      "time.BodyGyroJerk.X.std"      
## [31] "time.BodyGyroJerk.Y.std"       "time.BodyGyroJerk.Z.std"      
## [33] "time.BodyAccMag.mean"          "time.BodyAccMag.std"          
## [35] "time.GravityAccMag.mean"       "time.GravityAccMag.std"       
## [37] "time.BodyAccJerkMag.mean"      "time.BodyAccJerkMag.std"      
## [39] "time.BodyGyroMag.mean"         "time.BodyGyroMag.std"         
## [41] "time.BodyGyroJerkMag.mean"     "time.BodyGyroJerkMag.std"     
## [43] "freq.BodyAcc.X.mean"           "freq.BodyAcc.Y.mean"          
## [45] "freq.BodyAcc.Z.mean"           "freq.BodyAcc.X.std"           
## [47] "freq.BodyAcc.Y.std"            "freq.BodyAcc.Z.std"           
## [49] "freq.BodyAccJerk.X.mean"       "freq.BodyAccJerk.Y.mean"      
## [51] "freq.BodyAccJerk.Z.mean"       "freq.BodyAccJerk.X.std"       
## [53] "freq.BodyAccJerk.Y.std"        "freq.BodyAccJerk.Z.std"       
## [55] "freq.BodyGyro.X.mean"          "freq.BodyGyro.Y.mean"         
## [57] "freq.BodyGyro.Z.mean"          "freq.BodyGyro.X.std"          
## [59] "freq.BodyGyro.Y.std"           "freq.BodyGyro.Z.std"          
## [61] "freq.BodyAccMag.mean"          "freq.BodyAccMag.std"          
## [63] "freq.BodyBodyAccJerkMag.mean"  "freq.BodyBodyAccJerkMag.std"  
## [65] "freq.BodyBodyGyroMag.mean"     "freq.BodyBodyGyroMag.std"     
## [67] "freq.BodyBodyGyroJerkMag.mean" "freq.BodyBodyGyroJerkMag.std"
```

### A few rows of data


```r
head(tidyDataset,10)
```

```
## Source: local data frame [10 x 68]
## Groups: Subject.ID [2]
## 
##    Subject.ID      Activity.Name time.BodyAcc.X.mean time.BodyAcc.Y.mean
##         (int)             (fctr)               (dbl)               (dbl)
## 1           1             LAYING           0.2215982        -0.040513953
## 2           1            SITTING           0.2612376        -0.001308288
## 3           1           STANDING           0.2789176        -0.016137590
## 4           1            WALKING           0.2773308        -0.017383819
## 5           1 WALKING_DOWNSTAIRS           0.2891883        -0.009918505
## 6           1   WALKING_UPSTAIRS           0.2554617        -0.023953149
## 7           2             LAYING           0.2813734        -0.018158740
## 8           2            SITTING           0.2770874        -0.015687994
## 9           2           STANDING           0.2779115        -0.018420827
## 10          2            WALKING           0.2764266        -0.018594920
## Variables not shown: time.BodyAcc.Z.mean (dbl), time.BodyAcc.X.std (dbl),
##   time.BodyAcc.Y.std (dbl), time.BodyAcc.Z.std (dbl),
##   time.GravityAcc.X.mean (dbl), time.GravityAcc.Y.mean (dbl),
##   time.GravityAcc.Z.mean (dbl), time.GravityAcc.X.std (dbl),
##   time.GravityAcc.Y.std (dbl), time.GravityAcc.Z.std (dbl),
##   time.BodyAccJerk.X.mean (dbl), time.BodyAccJerk.Y.mean (dbl),
##   time.BodyAccJerk.Z.mean (dbl), time.BodyAccJerk.X.std (dbl),
##   time.BodyAccJerk.Y.std (dbl), time.BodyAccJerk.Z.std (dbl),
##   time.BodyGyro.X.mean (dbl), time.BodyGyro.Y.mean (dbl),
##   time.BodyGyro.Z.mean (dbl), time.BodyGyro.X.std (dbl),
##   time.BodyGyro.Y.std (dbl), time.BodyGyro.Z.std (dbl),
##   time.BodyGyroJerk.X.mean (dbl), time.BodyGyroJerk.Y.mean (dbl),
##   time.BodyGyroJerk.Z.mean (dbl), time.BodyGyroJerk.X.std (dbl),
##   time.BodyGyroJerk.Y.std (dbl), time.BodyGyroJerk.Z.std (dbl),
##   time.BodyAccMag.mean (dbl), time.BodyAccMag.std (dbl),
##   time.GravityAccMag.mean (dbl), time.GravityAccMag.std (dbl),
##   time.BodyAccJerkMag.mean (dbl), time.BodyAccJerkMag.std (dbl),
##   time.BodyGyroMag.mean (dbl), time.BodyGyroMag.std (dbl),
##   time.BodyGyroJerkMag.mean (dbl), time.BodyGyroJerkMag.std (dbl),
##   freq.BodyAcc.X.mean (dbl), freq.BodyAcc.Y.mean (dbl),
##   freq.BodyAcc.Z.mean (dbl), freq.BodyAcc.X.std (dbl), freq.BodyAcc.Y.std
##   (dbl), freq.BodyAcc.Z.std (dbl), freq.BodyAccJerk.X.mean (dbl),
##   freq.BodyAccJerk.Y.mean (dbl), freq.BodyAccJerk.Z.mean (dbl),
##   freq.BodyAccJerk.X.std (dbl), freq.BodyAccJerk.Y.std (dbl),
##   freq.BodyAccJerk.Z.std (dbl), freq.BodyGyro.X.mean (dbl),
##   freq.BodyGyro.Y.mean (dbl), freq.BodyGyro.Z.mean (dbl),
##   freq.BodyGyro.X.std (dbl), freq.BodyGyro.Y.std (dbl),
##   freq.BodyGyro.Z.std (dbl), freq.BodyAccMag.mean (dbl),
##   freq.BodyAccMag.std (dbl), freq.BodyBodyAccJerkMag.mean (dbl),
##   freq.BodyBodyAccJerkMag.std (dbl), freq.BodyBodyGyroMag.mean (dbl),
##   freq.BodyBodyGyroMag.std (dbl), freq.BodyBodyGyroJerkMag.mean (dbl),
##   freq.BodyBodyGyroJerkMag.std (dbl)
```

### Summary of variables


```r
summary(tidyDataset)
```

```
##    Subject.ID              Activity.Name time.BodyAcc.X.mean
##  Min.   : 1.0   LAYING            :30    Min.   :0.2216     
##  1st Qu.: 8.0   SITTING           :30    1st Qu.:0.2712     
##  Median :15.5   STANDING          :30    Median :0.2770     
##  Mean   :15.5   WALKING           :30    Mean   :0.2743     
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:30    3rd Qu.:0.2800     
##  Max.   :30.0   WALKING_UPSTAIRS  :30    Max.   :0.3015     
##  time.BodyAcc.Y.mean time.BodyAcc.Z.mean time.BodyAcc.X.std
##  Min.   :-0.040514   Min.   :-0.15251    Min.   :-0.9961   
##  1st Qu.:-0.020022   1st Qu.:-0.11207    1st Qu.:-0.9799   
##  Median :-0.017262   Median :-0.10819    Median :-0.7526   
##  Mean   :-0.017876   Mean   :-0.10916    Mean   :-0.5577   
##  3rd Qu.:-0.014936   3rd Qu.:-0.10443    3rd Qu.:-0.1984   
##  Max.   :-0.001308   Max.   :-0.07538    Max.   : 0.6269   
##  time.BodyAcc.Y.std time.BodyAcc.Z.std time.GravityAcc.X.mean
##  Min.   :-0.99024   Min.   :-0.9877    Min.   :-0.6800       
##  1st Qu.:-0.94205   1st Qu.:-0.9498    1st Qu.: 0.8376       
##  Median :-0.50897   Median :-0.6518    Median : 0.9208       
##  Mean   :-0.46046   Mean   :-0.5756    Mean   : 0.6975       
##  3rd Qu.:-0.03077   3rd Qu.:-0.2306    3rd Qu.: 0.9425       
##  Max.   : 0.61694   Max.   : 0.6090    Max.   : 0.9745       
##  time.GravityAcc.Y.mean time.GravityAcc.Z.mean time.GravityAcc.X.std
##  Min.   :-0.47989       Min.   :-0.49509       Min.   :-0.9968      
##  1st Qu.:-0.23319       1st Qu.:-0.11726       1st Qu.:-0.9825      
##  Median :-0.12782       Median : 0.02384       Median :-0.9695      
##  Mean   :-0.01621       Mean   : 0.07413       Mean   :-0.9638      
##  3rd Qu.: 0.08773       3rd Qu.: 0.14946       3rd Qu.:-0.9509      
##  Max.   : 0.95659       Max.   : 0.95787       Max.   :-0.8296      
##  time.GravityAcc.Y.std time.GravityAcc.Z.std time.BodyAccJerk.X.mean
##  Min.   :-0.9942       Min.   :-0.9910       Min.   :0.04269        
##  1st Qu.:-0.9711       1st Qu.:-0.9605       1st Qu.:0.07396        
##  Median :-0.9590       Median :-0.9450       Median :0.07640        
##  Mean   :-0.9524       Mean   :-0.9364       Mean   :0.07947        
##  3rd Qu.:-0.9370       3rd Qu.:-0.9180       3rd Qu.:0.08330        
##  Max.   :-0.6436       Max.   :-0.6102       Max.   :0.13019        
##  time.BodyAccJerk.Y.mean time.BodyAccJerk.Z.mean time.BodyAccJerk.X.std
##  Min.   :-0.0386872      Min.   :-0.067458       Min.   :-0.9946       
##  1st Qu.: 0.0004664      1st Qu.:-0.010601       1st Qu.:-0.9832       
##  Median : 0.0094698      Median :-0.003861       Median :-0.8104       
##  Mean   : 0.0075652      Mean   :-0.004953       Mean   :-0.5949       
##  3rd Qu.: 0.0134008      3rd Qu.: 0.001958       3rd Qu.:-0.2233       
##  Max.   : 0.0568186      Max.   : 0.038053       Max.   : 0.5443       
##  time.BodyAccJerk.Y.std time.BodyAccJerk.Z.std time.BodyGyro.X.mean
##  Min.   :-0.9895        Min.   :-0.99329       Min.   :-0.20578    
##  1st Qu.:-0.9724        1st Qu.:-0.98266       1st Qu.:-0.04712    
##  Median :-0.7756        Median :-0.88366       Median :-0.02871    
##  Mean   :-0.5654        Mean   :-0.73596       Mean   :-0.03244    
##  3rd Qu.:-0.1483        3rd Qu.:-0.51212       3rd Qu.:-0.01676    
##  Max.   : 0.3553        Max.   : 0.03102       Max.   : 0.19270    
##  time.BodyGyro.Y.mean time.BodyGyro.Z.mean time.BodyGyro.X.std
##  Min.   :-0.20421     Min.   :-0.07245     Min.   :-0.9943    
##  1st Qu.:-0.08955     1st Qu.: 0.07475     1st Qu.:-0.9735    
##  Median :-0.07318     Median : 0.08512     Median :-0.7890    
##  Mean   :-0.07426     Mean   : 0.08744     Mean   :-0.6916    
##  3rd Qu.:-0.06113     3rd Qu.: 0.10177     3rd Qu.:-0.4414    
##  Max.   : 0.02747     Max.   : 0.17910     Max.   : 0.2677    
##  time.BodyGyro.Y.std time.BodyGyro.Z.std time.BodyGyroJerk.X.mean
##  Min.   :-0.9942     Min.   :-0.9855     Min.   :-0.15721        
##  1st Qu.:-0.9629     1st Qu.:-0.9609     1st Qu.:-0.10322        
##  Median :-0.8017     Median :-0.8010     Median :-0.09868        
##  Mean   :-0.6533     Mean   :-0.6164     Mean   :-0.09606        
##  3rd Qu.:-0.4196     3rd Qu.:-0.3106     3rd Qu.:-0.09110        
##  Max.   : 0.4765     Max.   : 0.5649     Max.   :-0.02209        
##  time.BodyGyroJerk.Y.mean time.BodyGyroJerk.Z.mean time.BodyGyroJerk.X.std
##  Min.   :-0.07681         Min.   :-0.092500        Min.   :-0.9965        
##  1st Qu.:-0.04552         1st Qu.:-0.061725        1st Qu.:-0.9800        
##  Median :-0.04112         Median :-0.053430        Median :-0.8396        
##  Mean   :-0.04269         Mean   :-0.054802        Mean   :-0.7036        
##  3rd Qu.:-0.03842         3rd Qu.:-0.048985        3rd Qu.:-0.4629        
##  Max.   :-0.01320         Max.   :-0.006941        Max.   : 0.1791        
##  time.BodyGyroJerk.Y.std time.BodyGyroJerk.Z.std time.BodyAccMag.mean
##  Min.   :-0.9971         Min.   :-0.9954         Min.   :-0.9865     
##  1st Qu.:-0.9832         1st Qu.:-0.9848         1st Qu.:-0.9573     
##  Median :-0.8942         Median :-0.8610         Median :-0.4829     
##  Mean   :-0.7636         Mean   :-0.7096         Mean   :-0.4973     
##  3rd Qu.:-0.5861         3rd Qu.:-0.4741         3rd Qu.:-0.0919     
##  Max.   : 0.2959         Max.   : 0.1932         Max.   : 0.6446     
##  time.BodyAccMag.std time.GravityAccMag.mean time.GravityAccMag.std
##  Min.   :-0.9865     Min.   :-0.9865         Min.   :-0.9865       
##  1st Qu.:-0.9430     1st Qu.:-0.9573         1st Qu.:-0.9430       
##  Median :-0.6074     Median :-0.4829         Median :-0.6074       
##  Mean   :-0.5439     Mean   :-0.4973         Mean   :-0.5439       
##  3rd Qu.:-0.2090     3rd Qu.:-0.0919         3rd Qu.:-0.2090       
##  Max.   : 0.4284     Max.   : 0.6446         Max.   : 0.4284       
##  time.BodyAccJerkMag.mean time.BodyAccJerkMag.std time.BodyGyroMag.mean
##  Min.   :-0.9928          Min.   :-0.9946         Min.   :-0.9807      
##  1st Qu.:-0.9807          1st Qu.:-0.9765         1st Qu.:-0.9461      
##  Median :-0.8168          Median :-0.8014         Median :-0.6551      
##  Mean   :-0.6079          Mean   :-0.5842         Mean   :-0.5652      
##  3rd Qu.:-0.2456          3rd Qu.:-0.2173         3rd Qu.:-0.2159      
##  Max.   : 0.4345          Max.   : 0.4506         Max.   : 0.4180      
##  time.BodyGyroMag.std time.BodyGyroJerkMag.mean time.BodyGyroJerkMag.std
##  Min.   :-0.9814      Min.   :-0.99732          Min.   :-0.9977         
##  1st Qu.:-0.9476      1st Qu.:-0.98515          1st Qu.:-0.9805         
##  Median :-0.7420      Median :-0.86479          Median :-0.8809         
##  Mean   :-0.6304      Mean   :-0.73637          Mean   :-0.7550         
##  3rd Qu.:-0.3602      3rd Qu.:-0.51186          3rd Qu.:-0.5767         
##  Max.   : 0.3000      Max.   : 0.08758          Max.   : 0.2502         
##  freq.BodyAcc.X.mean freq.BodyAcc.Y.mean freq.BodyAcc.Z.mean
##  Min.   :-0.9952     Min.   :-0.98903    Min.   :-0.9895    
##  1st Qu.:-0.9787     1st Qu.:-0.95361    1st Qu.:-0.9619    
##  Median :-0.7691     Median :-0.59498    Median :-0.7236    
##  Mean   :-0.5758     Mean   :-0.48873    Mean   :-0.6297    
##  3rd Qu.:-0.2174     3rd Qu.:-0.06341    3rd Qu.:-0.3183    
##  Max.   : 0.5370     Max.   : 0.52419    Max.   : 0.2807    
##  freq.BodyAcc.X.std freq.BodyAcc.Y.std freq.BodyAcc.Z.std
##  Min.   :-0.9966    Min.   :-0.99068   Min.   :-0.9872   
##  1st Qu.:-0.9820    1st Qu.:-0.94042   1st Qu.:-0.9459   
##  Median :-0.7470    Median :-0.51338   Median :-0.6441   
##  Mean   :-0.5522    Mean   :-0.48148   Mean   :-0.5824   
##  3rd Qu.:-0.1966    3rd Qu.:-0.07913   3rd Qu.:-0.2655   
##  Max.   : 0.6585    Max.   : 0.56019   Max.   : 0.6871   
##  freq.BodyAccJerk.X.mean freq.BodyAccJerk.Y.mean freq.BodyAccJerk.Z.mean
##  Min.   :-0.9946         Min.   :-0.9894         Min.   :-0.9920        
##  1st Qu.:-0.9828         1st Qu.:-0.9725         1st Qu.:-0.9796        
##  Median :-0.8126         Median :-0.7817         Median :-0.8707        
##  Mean   :-0.6139         Mean   :-0.5882         Mean   :-0.7144        
##  3rd Qu.:-0.2820         3rd Qu.:-0.1963         3rd Qu.:-0.4697        
##  Max.   : 0.4743         Max.   : 0.2767         Max.   : 0.1578        
##  freq.BodyAccJerk.X.std freq.BodyAccJerk.Y.std freq.BodyAccJerk.Z.std
##  Min.   :-0.9951        Min.   :-0.9905        Min.   :-0.993108     
##  1st Qu.:-0.9847        1st Qu.:-0.9737        1st Qu.:-0.983747     
##  Median :-0.8254        Median :-0.7852        Median :-0.895121     
##  Mean   :-0.6121        Mean   :-0.5707        Mean   :-0.756489     
##  3rd Qu.:-0.2475        3rd Qu.:-0.1685        3rd Qu.:-0.543787     
##  Max.   : 0.4768        Max.   : 0.3498        Max.   :-0.006236     
##  freq.BodyGyro.X.mean freq.BodyGyro.Y.mean freq.BodyGyro.Z.mean
##  Min.   :-0.9931      Min.   :-0.9940      Min.   :-0.9860     
##  1st Qu.:-0.9697      1st Qu.:-0.9700      1st Qu.:-0.9624     
##  Median :-0.7300      Median :-0.8141      Median :-0.7909     
##  Mean   :-0.6367      Mean   :-0.6767      Mean   :-0.6044     
##  3rd Qu.:-0.3387      3rd Qu.:-0.4458      3rd Qu.:-0.2635     
##  Max.   : 0.4750      Max.   : 0.3288      Max.   : 0.4924     
##  freq.BodyGyro.X.std freq.BodyGyro.Y.std freq.BodyGyro.Z.std
##  Min.   :-0.9947     Min.   :-0.9944     Min.   :-0.9867    
##  1st Qu.:-0.9750     1st Qu.:-0.9602     1st Qu.:-0.9643    
##  Median :-0.8086     Median :-0.7964     Median :-0.8224    
##  Mean   :-0.7110     Mean   :-0.6454     Mean   :-0.6577    
##  3rd Qu.:-0.4813     3rd Qu.:-0.4154     3rd Qu.:-0.3916    
##  Max.   : 0.1966     Max.   : 0.6462     Max.   : 0.5225    
##  freq.BodyAccMag.mean freq.BodyAccMag.std freq.BodyBodyAccJerkMag.mean
##  Min.   :-0.9868      Min.   :-0.9876     Min.   :-0.9940             
##  1st Qu.:-0.9560      1st Qu.:-0.9452     1st Qu.:-0.9770             
##  Median :-0.6703      Median :-0.6513     Median :-0.7940             
##  Mean   :-0.5365      Mean   :-0.6210     Mean   :-0.5756             
##  3rd Qu.:-0.1622      3rd Qu.:-0.3654     3rd Qu.:-0.1872             
##  Max.   : 0.5866      Max.   : 0.1787     Max.   : 0.5384             
##  freq.BodyBodyAccJerkMag.std freq.BodyBodyGyroMag.mean
##  Min.   :-0.9944             Min.   :-0.9865          
##  1st Qu.:-0.9752             1st Qu.:-0.9616          
##  Median :-0.8126             Median :-0.7657          
##  Mean   :-0.5992             Mean   :-0.6671          
##  3rd Qu.:-0.2668             3rd Qu.:-0.4087          
##  Max.   : 0.3163             Max.   : 0.2040          
##  freq.BodyBodyGyroMag.std freq.BodyBodyGyroJerkMag.mean
##  Min.   :-0.9815          Min.   :-0.9976              
##  1st Qu.:-0.9488          1st Qu.:-0.9813              
##  Median :-0.7727          Median :-0.8779              
##  Mean   :-0.6723          Mean   :-0.7564              
##  3rd Qu.:-0.4277          3rd Qu.:-0.5831              
##  Max.   : 0.2367          Max.   : 0.1466              
##  freq.BodyBodyGyroJerkMag.std
##  Min.   :-0.9976             
##  1st Qu.:-0.9802             
##  Median :-0.8941             
##  Mean   :-0.7715             
##  3rd Qu.:-0.6081             
##  Max.   : 0.2878
```
