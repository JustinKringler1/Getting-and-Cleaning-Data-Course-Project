#Loading dplyr for the pipe opperators.
library(dplyr)

#Reading all our files in (Files will bbe linked you need to change path to your own location)
features <- read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))
train_x<-read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/train/X_train.txt",col.names = features$functions)
train_y<-read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/train/y_train.txt",col.names = "label")
test_x<-read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
test_y<-read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/test/y_test.txt", col.names = "label")
train_subject<-read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
test_subject<-read.table("C:/Users/cc13m/OneDrive/Desktop/Data Science Resources/Getting_Cleaning_Data_Assignment/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

#Merging all our files into a dataset
X <- rbind(train_x, test_x)
Y <- rbind(train_y, test_y)
Subject <- rbind(train_subject, test_subject)
Merged_Data <- cbind(Subject, Y, X)

#Selecting only subjects that have mean and std
TidyData <- Merged_Data %>% select(subject, label, contains("mean"), contains("std"))

#Changing the label from the number to the name
TidyData$label <- activities[TidyData$label, 2]

#Calculating mean of each variable for each activity and each subject.
completed_data <- TidyData %>%
  group_by(subject, label) %>%
  summarise_all(funs(mean))

#Exporting the final product as a text file.
write.table(completed_data, "FinalTidyData.txt", row.name=FALSE)