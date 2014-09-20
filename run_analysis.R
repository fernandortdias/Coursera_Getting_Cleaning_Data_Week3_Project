#1. Merge the training and the test sets to create one data set:

#1.1 Load train data, activity labels and subjects from "train" folder on the current directory.
x <- read.table("train/X_train.txt")
y <- read.table("train/y_train.txt")
s <- read.table("train/subject_train.txt")

#1.2 Append subject index and activity label to train data.
x1 <- data.frame(
  subject = s$V1,
  label = y$V1, 
  x)

#1.3 Load test data, activity labels and subjects from "test" folder on the current directory.
x <- read.table("test/X_test.txt")
y <- read.table("test/y_test.txt")
s <- read.table("test/subject_test.txt")

#1.4 Append subject index and activity label to train data.
x2 <- data.frame(
  subject = s$V1,
  label = y$V1, 
  x)

#1.5 Save train and test data into one single data set.
x <- rbind(x1, x2)

#2. Extract only the measurements on the mean and standard deviation for each measurement:
#2.1 Load feature (measurement) list from file "features.txt" on the current directory.
features <- read.table("features.txt", stringsAsFactors = FALSE)

#2.2 Appropriately label the data set with descriptive variable names from the feature list loaded.
names(x)<-c("subject", "label", features$V2)

#2.3 Keep only measurements that represent mean or standard deviation and drop any other.
x <- 
  x[, 
    sort(c(1,2,
      2+grep("-mean()", features[,2], fixed = TRUE),
      2+grep("-std()", features[,2], fixed = TRUE)
      ))
    ]

#3. Use descriptive activity names to name the activities in the data set:

#3.1 Load activity name list from "activity_labels.txt" file on the current directory and rename its columns.
activities <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
names(activities) <- c("label","activity")

#3.2 Merge activity description to data using common column (activity label).
x <- merge(activities, x)

#3.3 Reorder data rows by subject and activity description and drop "row.names" column added by reordering.
x <- x[order(x$subject,x$activity),]
row.names(x) <- NULL

#3.4 Drop activity label column and set subject and activity description as the first two columns, followed by features (measurements).
x1 <- x[,c(3,2,4:69)]

#4. Appropriately labels the data set with descriptive variable names (already done at step #2.2).

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#5.1 Load reshape2 library.
library(reshape2)

#5.2 "Melt" data set from step 4, so each feature (measurement) are listed in a separate row for each variable, activity and subject. 
x2 <- melt(x1,id=c("subject", "activity"), measure.vars=names(x1)[3:68])

#5.3 Agreggate the average for each variable (feature values or "measurements") by subject, activity and variable.
x2 <- aggregate(value ~ subject + activity + variable, data = x2, mean)

#5.4 Reorder data rows by subject and activity description and drop row.names added by reordering.
x2 <- x2[order(x2$subject,x2$activity,x2$variable),]

#5.5 Write data into "tidy.txt" file on the current directory.
row.names(x2) <- NULL

#5.6 Write data into a file on the current directory
write.table(x2,file="tidy.txt",row.names=FALSE)