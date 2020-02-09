Source data
This project used the dataset named Human Activity Recognition Using Smartphones (link below). This data was collected from the accelerometers from the Samsung Galaxy S smartphone.

Link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Explanation of variables and the steps that I performed
X_train, Y_train, subject_train, X_test, Y_test, subject_test, features, and labels are from the source data.

All of the above data are merged into a dataframe named Merged_Data. First, Y_train, subject_train, X_train are merged with cbind and the same for the test sets. Then, those train and test sets are merged with rbind.

After that, I named the variables appropriately using the names in the features dataset.

In order to give descriptive names to the activities in the dataset, I first made a character vector variable named Activitiy_label. Then, I named each descriptive activity name as from 1 to 6 to correspond to the coded numbers in the original dataset. That is, Activity_label looks liks this:

> Activity_label

1     WALKING               
2     WALKING_UPSTAIRS               
3     WALKING_DOWNSTAIRS               
4     SITTING
5     STANDING               
6     LAYING

This way, I was able to extract the descriptive activity names by using the coded numbers. This was done by using the following code:

activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
Next step was to extract only the measurements on the mean and standard deviation for each measurement. In order to do that, I first created indices vaiable for (obviously) indexing. I used grep() to get indices of the variable names that contain 'mean()' and 'std()', not to mention 'activity' and 'subject'. And then, I simply extracted only the variables of interest and assign them to a dataframe named extracted.

Finally, I created a TidyData with the average of each variable for each activity and each subject. I used aggregate() function. 

TidyData looks like this:

> Tidydata[1:6, 1:6]
    subjectId activityId tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X
1           1          1         0.2773308      -0.017383819        -0.1111481      -0.28374026
31          1          2         0.2554617      -0.023953149        -0.0973020      -0.35470803
61          1          3         0.2891883      -0.009918505        -0.1075662       0.03003534
91          1          4         0.2612376      -0.001308288        -0.1045442      -0.97722901
121         1          5         0.2789176      -0.016137590        -0.1106018      -0.99575990
151         1          6         0.2215982      -0.040513953        -0.1132036      -0.92805647
