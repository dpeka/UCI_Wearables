# UCI_Wearables

This project satisfies the requirements for the "Getting and Cleaning Data" class project.
The main R script is located in the "run_analysis.R" file.
Two big assumptions for the code to work:
1 - Assumes data has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2 - Assumes all data is unzipped and placed in a folder called "uci_data" in the working directory of R

The class project has the following objectives:
- Merge the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The "run_analysis.R" script accomplishes the above through the following high level pseudo-code:
- Loads the training and testing data observations into separate data frames.
- Loads the corresponding subject and activity identifiers into data frames.
- Converts the activity identified from a number to the activity description.
- Uses the features text file to rename the columns of the data observations to something descriptive.
- The subject and descriptive activity variables are appended to the data sets.
- The training and testing data sets are added together.
- A new data set is created which contains the subject, activity, and the mean and standard deviation variables for each measurement.
- Finally, the data is grouped by activity, subject, and the mean for each variable is then calculated - and stored in a new data frame.

The final data set is a tidy data set.  Each row is an observation that corresponds to an activity and subject combination.  All column values are the average observed for the particular activity/subject combination - and each column is an independent variable (tidy data in wide format).
