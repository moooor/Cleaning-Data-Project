# Loading required packages
library(dplyr);

# Downloading dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

# Unzipping dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Read downloaded files and create tables
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

# 4. Assigning all data frames & labeling the data set with descriptive variable names

# Reading trainings & testing tables:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Read feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Read activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#3. Use decriptive activity names to name the activities in the dataset
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# 1. Merges the training and the test sets to create one data set.

mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
Merged_Data <- rbind(mrg_train, mrg_test)

colNames <- colnames(Merged_Data)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_and_std <- (grepl("activityId" , colNames) | 
                 grepl("subjectId" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
)

AddMeanAndStd <- Merged_Data[ , mean_and_std == TRUE]

setWithActivityNames <- merge(AddMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

#5. Create a second, independent dataset with the average of each variable for each activity and each subject
Tidydata <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
Tidydata <- Tidydata[order(Tidydata$subjectId, Tidydata$activityId),]

write.table(Tidydata, "Tidydata.txt", row.name=FALSE)