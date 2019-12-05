# Week-4-Assignment
A repository for my assignment for "Getting and Cleaning Data in R"

The run_analysis.R file begins by loading in plyr, dplyr, and reshape2 for the functions 'mutate','melt', and 'dcast'.
After which the script reads all of the relevant data:
  1. Reads the feature names from "features.txt" for the sake of identifying measurees with standard deviation and mean
    a. At this point the script extracts the variables from 'features.txt' that contain 'mean()' or 'std()' using
        the 'filter' function
  2. Reads all of the training data
  3. Reads all of the test data
Next it combines the test and training data for each variable using the 'rbind' function.
  1. The subject variable is combined into one and renamed 'subject_id'
  2. The activity variable is combined into one data set and renamed 'activity_type'
     a. 'activity_type' is converted into a factor variable and the values are converted into descriptive
        names corresponding to the 'activity_labels' file.
  3. The measure variables are combined into one data set and only the columns that contain 'mean()' or 'std()'
      are selected and are renamed according to the descriptions in 'features.txt'.
The subject_id, activity_type, and all mean and standard deviation variables are combined into one data frame.
The script uses the 'melt' and 'dcast' functions to condense the data frame into one that contains the mean of each variable for each subject and each activity type.
Finally the resulting data frame from the previous step is saved to a file called, 'Week_4_Assignment.txt'.
