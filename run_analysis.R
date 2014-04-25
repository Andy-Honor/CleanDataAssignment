# Please setwd to the directory where the folder UCI HAR Dataset is.

# Get those columns that will be remained( mean and std )
features <- read.table( "./UCI HAR Dataset/features.txt",header=FALSE,colClasses=c("numeric","character") );
index <- grep( "mean|std",features$V2 )
names <- features$V2

# Get train data
setwd( "./UCI HAR Dataset/train" );
xTrain <- read.table( "./X_train.txt",header=FALSE );
yTrain <- read.table( "./y_train.txt",header=FALSE );
subjectTrain <- read.table( "./subject_train.txt",header=FALSE );
xTrain <- xTrain[,index]

# Get test data
setwd( "./UCI HAR Dataset/test" );
xTest <- read.table( "./X_test.txt",header=FALSE );
yTest <- read.table( "./y_test.txt",header=FALSE );
subjectTest <- read.table( "./subject_test.txt",header=FALSE );
xTest <- xTest[,index]

# merge train data and test data
x <- rbind( xTrain,xTest )
y <- as.matrix( c(yTrain,yTest),ncol=1 )
subject <- as.matrix( c(subjectTrain,subjectTest),ncol=1 )

# output the tidy data
data.frame( cbind( subject,y,x),sample( names,replace=TRUE)