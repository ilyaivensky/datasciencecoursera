# store the current directory
initial.dir<-getwd()

# change to the new directory
setwd("UCI HAR Dataset")

# read testing data
test_data <- read.table("test/X_test.txt")

# read training data
train_data <- read.table("train/X_train.txt")

# combine training and testing data
all_data <- rbind(train_data, test_data)

# read feature names
features <-read.table("features.txt")

# rename columns with feature names 
colnames(all_data) <- features[, 2]

# create a subset with mean and std features
all_data_mean_std <- all_data[,grepl("(mean\\(\\)|std\\(\\))", names(all_data), ignore.case=FALSE)]

# write all_data_mean_std to the disc
write.table(all_data_mean_std, file="all_data_mean_std.txt", row.names=FALSE)

# change back to the original directory
setwd(initial.dir)