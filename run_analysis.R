library(plyr)
library(dplyr)
library(reshape2)
#Get feature mapping to find the mean and standard deviation columns

feature <- read.table("features.txt")

#Return only measurements for mean and standard deviation
mean_and_std <- filter(feature,grepl("mean()|std()",feature$V2))

#Get the training set

subject_train <- read.table("./train/subject_train.txt")
activity_train <- read.table("./train/y_train.txt")
measures_train <- read.table("./train/X_train.txt")

#Get the test set

subject_test <- read.table("./test/subject_test.txt")
activity_test <- read.table("./test/y_test.txt")
measures_test <- read.table("./test/X_test.txt")

#Merge the test and train data for subjects and rename column
subject <- rbind(subject_test,subject_train)
names(subject) <- c("subject_id")

#Merge the test and train data for activity and rename column
activity <- rbind(activity_test, activity_train)
names(activity) <- c("activity_type")

#change activity type to factor
activity$activity_type <- factor(activity$activity_type)
#change activity type variables from number to descriptions
activity = activity %>% 
    mutate(activity_type = 
               case_when(activity_type == "1" ~ "Walking",
                        activity_type == "2" ~ "Walking Upstairs",
                        activity_type == "3" ~ "Walking Downstairs",
                        activity_type == "4" ~ "Sitting",
                        activity_type == "5" ~ "Standing",
                        activity_type == "6" ~ "Laying"))

#Merge the test and train data for the measures and rename columns
measures <- rbind(measures_test,measures_train)
measures2 <- measures[,mean_and_std[,1]]
names(measures2) <- mean_and_std[,2]

#combine all of the data into one data frame
all_data <- data.frame(subject,activity,measures2)

#Create final data set and save to a txt file using melt and dcast
dataMelt <- melt(all_data,
                 id = c("subject_id","activity_type"),
                 measure.vars =c(3:ncol(all_data)))
dataCast <- dcast(dataMelt,subject_id + activity_type ~ variable, mean)


write.table(dataCast,"Week_4_Assignment.txt",row.names=FALSE)
