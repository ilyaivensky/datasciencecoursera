# This script combines training and testing data of all activities performed 
# by all subjects, selects mean and standard deviation features, and calculates 
# mean of those features broken by activity and subject

library(plyr) # we need it for ddply

# Read testing data
test_features <- read.table("test/X_test.txt")
test_labels <- read.table("test/y_test.txt")
test_subjects <- read.table("test/subject_test.txt")

# Read training data
train_features <- read.table("train/X_train.txt")
train_labels <- read.table("train/y_train.txt")
train_subjects <- read.table("train/subject_train.txt")

# Combine training and testing data
all_features <- rbind(train_features, test_features)
all_labels <- rbind(train_labels, test_labels)
all_subjects <- rbind(train_subjects, test_subjects)

# Read feature names
features <-read.table("features.txt")

# Rename columns using feature names
colnames(all_features) <- features[, 2]

# Extract only the measurements on the mean and standard deviation for each measurement.
features_mean_std <- all_features[,grepl("(mean\\(\\)|std\\(\\))", names(all_features), ignore.case=FALSE)]

# Read descriptions of activities
activities <- read.table("activity_labels.txt")

# Apply descriptions of activities on labels
all_activities <- apply(all_labels, 1, function(x) activities[x,2])

# Create table with activity names and subjects
# (each row of that table will correspond to the row in the features)
flabels <- data.frame(all_activities, all_subjects)

# Combine labels and selected features into a single table
labeled_features <- cbind(flabels, features_mean_std)

# Calculate mean of each feature broken by activity and subject
data <- ddply(labeled_features, c("Activities", "Subjects"), numcolwise(mean))

# Write result to the disc
write.table(data, file="all_data_mean_std.txt", row.names=FALSE)
