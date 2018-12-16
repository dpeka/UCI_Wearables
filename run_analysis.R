
#Assumptions:
# the data files should have been unzipped into a folder called "uci_data"
# the first level of the "uci_data" folder should contain:
# the activity_labels.txt, features.txt, features_info.txt and README.txt files
# in addition to the "test" and "train" folders.

library(dplyr)

# Reading the train data set, one can see that there are 
# 7352 observations of 561 features (or variables)
# Each observation corresponds to one of 6 activities that were tracked
# in the study.
train_set <- read.table("./uci_data/train/X_train.txt")
# Loading the test data set as well.
test_set <- read.table("./uci_data/test/X_test.txt")

# The name of the six different activities are stored in the activity_labels
# file.  Each activity is then codified into a number.
# For example: WALKING = 1
activity_labels <- read.table("./uci_data/activity_labels.txt")
# we rename the columns to something a little more descriptive.
names(activity_labels) <- c("code", "activity")

# Each observation in the data set corresponds to an activity.
# It's corresponding activity is stored in the labels file "y_train.txt"
# Loading the labels file for the training data provides
# a  single column table with 7352 observations.
# Each row contains the codified activity corresponding 
# to the observations in the data set.
train_labels <- read.table("./uci_data/train/y_train.txt")
# We also load the labels for the test data.
test_labels <- read.table("./uci_data/test/y_test.txt")
# As before, we provide a better name for the column.
names(test_labels) <- c("activity")
names(train_labels) <- c("activity")

# Each observation in the data set also corresponds to a subject (the study had 30 subjects).
# The subject corresponding to each observation are stored in the subject files.
# Subject data for the train and test data are loaded.
train_subjects <- read.table("./uci_data/train/subject_train.txt")
test_subjects <- read.table("./uci_data/test/subject_test.txt")
names(train_subjects) <- c("subject")
names(test_subjects) <- c("subject")

# the features/variables (column names) are stored in the features file.
# loading this file will gives us the names of the 561 features.
data_features <- read.table("./uci_data/features.txt")
# set a descriptive name for the columns of the features DF
names(data_features) <- c("column", "feature")

#we use the features to rename the columns of the data sets
names(train_set) <- data_features$feature
names(test_set) <- data_features$feature

# Below, we will translate the labels data sets from their codified
# number to their descriptive name (i.e. From 1 to WALKING)
# We do this for the test and train data.
test_descriptive_labels <- test_labels
test_descriptive_labels[] <- activity_labels$activity[
      match(unlist(test_labels), activity_labels$code)]

train_descriptive_labels <- train_labels
train_descriptive_labels[] <- activity_labels$activity[
      match(unlist(train_labels), activity_labels$code)]

# Finally, we are now ready to create a single data frame that contains:
# the subject, descriptive activity, meaningful column names, and data from the
# train and test data sets.

train_data <- cbind(train_subjects,train_descriptive_labels, train_set)
test_data <- cbind(test_subjects, test_descriptive_labels, test_set)
all_data <- rbind(train_data, test_data)

# Not all column names are unique.  We use the make.unique function
# to append a new number to duplicated column names.  
names(all_data) <- make.unique(names(all_data))

# Because we only want to keep the mean and std columns, we perform a 
# select.  The result is subject, activity and 66 other columns.
data_means_std <- all_data %>% select(subject, activity, matches('mean*\\(\\)'), contains('std'))

# For the final question, we group the data by activity and subject
# Since there are 6 activities and 30 subjects, we get 180 observations
# For each column, we provide the mean of the grouping.
grouped <- data_means_std %>% group_by(activity, subject) %>% summarise_all("mean")

# clean up environment from things no longer being used
keep <- c("all_data", "data_means_std", "grouped")
all_things <- ls()
rm(list = all_things[!all_things %in% keep])
rm(all_things)


