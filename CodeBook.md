CodeBook for run_analysis.R and two TIDY DATA sets
========================================================

## Extract Features
Only features about mean and std are retained.And finally, 79 features were obtained by:

```{r}
features <- read.table( "./UCI HAR Dataset/features.txt",header=FALSE,colClasses=c("numeric","character") );
index <- grep( "mean|std",features$V2 )
names <- features$V2[index]
```
All features could be viewed by **names**.

## Merge data set
Firstly, tranfer y_train to their descriptive activity names. For example, the following code could replace "1" with "WALKING"

```{r}
y <- gsub("1",labels$V2[1],y)
```

Then, we could merge train and test data set. For example, the following code can merge X_train and X_test:
```{r}
x <- rbind( xTrain,xTest )
```

Finally, a **data.frame** would be built and appropriate names were given for each columns.
```{r}
names <- c("subject","activity_label",names)
result <- data.frame( cbind( subject,y,x) )
colnames( result ) <- names
```

## Calculate the average
Function **tapply** was used to calculate the average for each activity and each subject.
```{r}
meanSubject <- as.numeric( tapply( result[,3],result$subject,mean ) )
meanActivity <- as.numeric( tapply( result[,3],result$activity_label,mean ) )
```

## Tidy data sets
Two data sets were generated.

**tidyData.txt**: contains 7352 rows and 81 columns. Every row replaced an observation. The first column replaced the subject label and the second one was activity labels. The left 79 columns were all 79 features.

**tidyMeanData.txt**: contains 36 rows and 81 columns. The first column was labels "Subject" or "Activity" to tell which kind of average was calculated for this row. The second column was still labels to tell which subject or which activity for this row. The left 79 columns were mean values for each feature of the corresponding subject or activity.




