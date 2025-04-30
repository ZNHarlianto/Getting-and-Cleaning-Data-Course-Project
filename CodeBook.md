This is the CodeBook for this project. The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

# Download the dataset
Dataset was downloaded and extracted under the folder called UCI HAR Dataset

# Assign each data to variables  & Merges the training and the test sets to create one data set
- Reads the training and testing datasets along with feature vectors and activity labels.
- Assigns variable names.
- Merges all data into one dataset.

# Extracts only the measurements on the mean and standard deviation for each measurement
Selects only the measurements corresponding to mean and standard deviation for each feature.

# Uses descriptive activity names to name the activities in the data set & Appropriately labels the data set with descriptive variable names
Uses descriptive activity names to label the activities in the dataset.
Appropriately labels the dataset with descriptive variable names.

# Creating a Final Data set that's tidy
- Generates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Writes the resulting tidy data set into a text file.

# Variables:
x_train, y_train, x_test, y_test, subject_train, and subject_test contain data from the downloaded files.
x_data, y_data, and subject_data merge the above datasets for further analysis.
features contains the correct names for the x_data dataset, applied to the column names for detailed reference.
