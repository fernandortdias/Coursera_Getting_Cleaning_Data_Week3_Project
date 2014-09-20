This "code book" describes the variables, data, and any transformations or work performed by the "run_analysis.R" script on this repo.

The input files for "run_analysis.R" represent data collected from accelerometers from Samsung Galaxy S smartphone. A zip file with all input files and a README.txt describing the input files is available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Before running "run_analysis.R" script, you must download the zip file above, unzip it at a chosen folder, and set the current directory as the one where the downloaded README.txt file is located.

In order to download the input files, go to the URL above, click on "Download Data Folder" and then at "UCI HAR Dataset.zip", a link that goes directly to the zip file. You may also click on the URL of that link, that we provide:

http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

The input files for the project can be also temporarily found also at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The "run_analysis.R" script reads the following input files from the unzipped files and folders:

"features.txt": List of all features.
"activity_labels.txt": Links the class labels with their activity name.
"train/X_train.txt": Training set.
"train/y_train.txt": Training labels.
"test/X_test.txt": Test set.
"test/y_test.txt": Test labels.
"train/subject_train.txt": Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 70% of the subjects were choosen for training data sets.
"test/subject_test.txt". The 30% of the subjects that were choosen for testing.

The dataset also includes the following files and folders not used by the "run_analysis.R" script:

"README.txt"
"features_info.txt": Shows information about the variables used on the feature vector.
"train/Inertial Signals/" and "test/Inertial Signals/" files and folders.

The "run_analysis.R" generates a single "tidy.txt" on its current directory. Below you find a detailed description of what "run_analysis.R" does in order to generate the "tidy.txt" file:

1. Merge the training and the test sets to create one data set:
1.1 Load train data, activity labels and subjects from "train" folder on the current directory.
1.2 Append subject index and activity label to train data.
1.3 Load test data, activity labels and subjects from "test" folder on the current directory.
1.4 Append subject index and activity label to train data.
1.5 Save train and test data into one single data set.

2. Extract only the measurements on the mean and standard deviation for each measurement:
2.1 Load feature (measurement) list from file "features.txt" on the current directory.
2.2 Appropriately label the data set with descriptive variable names from the feature list loaded.
2.3 Keep only measurements that represent mean or standard deviation and drop any other.

3. Use descriptive activity names to name the activities in the data set:
3.1 Load activity name list from "activity_labels.txt" file on the current directory and rename its columns.
3.2 Merge activity description to data using common column (activity label).
3.3 Reorder data rows by subject and activity description and drop "row.names" column added by reordering.
3.4 Drop activity label column and set subject and activity description as the first two columns, followed by features (measurements).

4. Appropriately labels the data set with descriptive variable names (already done at step #2.2).

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
5.1 Load reshape2 library.
5.2 "Melt" data set from step 4, so each feature (measurement) are listed in a separate row for each variable, activity and subject. 
5.3 Agreggate the average for each variable (feature values or "measurements") by subject, activity and variable.
5.4 Reorder data rows by subject and activity description and drop row.names added by reordering.
5.5 Write data into "tidy.txt" file on the current directory.

"tidy.txt" file is saved with one header row followed by 11880 data rows (as of today) and one additional last empty row. Columns are separated by space(s).

"tidy.txt" rows are:
"subject": The integer specifying the subject who performed the activity for each window sample, ranging from 1 to 30.
"activity": The name of the activity corresponding to the feature measurement. 
"variable": The feature measurement which average by subject and activity was calculated. Only feature measurements with "-std()" or "-mean()" are listed.
"value": The average of the variable listed, per subject and activity.

The "run_analysis.R" script is distributed AS-IS and no responsibility implied or explicit can be addressed to the author or their institutions for its use or misuse. Any commercial use is prohibited.

Use of the input dataset in publications must be acknowledged by referencing the following publication:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012