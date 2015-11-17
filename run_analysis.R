require("reshape2")
require("data.table")

# Get the data
X_test<-read.table("~/UCI HAR Dataset/test/X_test.txt")
X_train<-read.table("~/UCI HAR Dataset/train/X_train.txt")
subject_test<-read.table("~/UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("~/UCI HAR Dataset/train/subject_train.txt")
y_test<-read.table("~/UCI HAR Dataset/test/y_test.txt")
y_train<-read.table("~/UCI HAR Dataset/train/y_train.txt")


# Let's start with the 'test'-data
# column names
columnNames <- read.table("~/UCI HAR Dataset/features.txt")[,2]

# name columns
names(X_test)=columnNames

# select columns with means and SD's
extract_columnNames <- grepl("mean|std", columnNames)
X_test = X_test[,extract_columnNames]

# activities
activities <- read.table("~/UCI HAR Dataset/activity_labels.txt")[,2]
y_test[,2] = activities[y_test[,1]]
names(y_test) = c("Activity_ID", "activities")
names(subject_test) = "subject"

# Cbind test
alltest_data <- cbind(as.data.table(subject_test), y_test, X_test)

# and now all the same for the 'train'-data:
names(X_train) = columnNames

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_columnNames]

# Load activity data
y_train[,2] = activities[y_train[,1]]
names(y_train) = c("Activity_ID", "activities")
names(subject_train) = "subject"

## Cbind train
alltrain_data <- cbind(as.data.table(subject_train), y_train, X_train)


# Merge test and train data
data = rbind(alltest_data, alltrain_data)

id_labels   = c("subject", "Activity_ID", "activities")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data = dcast(melt_data, subject + activities ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt", row.names =FALSE)
