## Course Project -- Getting and Cleaning Data

The run_analysis.R script retrieves six files of raw observations and calcaulates means of 66 variables for each activity and each subject.

The run_analysis.R file consists of nine sections of code:

### Set the working directory:
=========================
The first section of code sets the working directory and creates a sub-directory called data, if it is not existent.

### Read data into R objects:
=========================
The seccond section of code reads the subject code file, the activity code file and the  files of training data and test data into the following R data frames:
* xSubjectTrainData: stores the subject code for training data
* yTrainData: stores activity code for training data
* xTrainData: stores observations of activities for training data

* xSubjectTestData: stores the subject code for test data
* yTestData: stores activity code for test data
* xTestData: stores observations of activities for test data


### Merge files of same categories:
=========================
The third section of code uses rbind() function to merge observation files, subject files and activity files and names the merged data frames as follows, respectively:
* measureData: stores all observations of train and test data
* subjectData: stores all subject code of train and test data
* activityData: stores all activity code of train and test data

### Name activity:
=========================
The fourth section of code has two parts:
* One part creates a converion function that assigns activity name according to the activity code
* The other part applies the above function to the activityData data frame and assigns a descriptive activity name to a newly added column.

Note: Instruction No. 3 is vague when it says, "Uses dscriptive names to name the activities in the data set". Does it mean to label the column (variable) names with descriptive names or to use activity name (walking, walking_upstairs...) instead of activity code (1,2,3...)? I interpreted the instruction as the latter. 

### Extract means and standard deviations:
=========================
The fifth section of code creates a vector of variables representing means and standard deviations of measurements and applies the vector to extract means and standard deviations from measureData.

### Merge files:
=========================
The sixth section of code uses cbind() to merge the following files into a new data frame:
* subjectData: data frame of subject code
* activityData: data frame consists of activity code and activity names
* extractedData: data of means and standard deviations of measurements.

Note: Instruction No. 4 is vague. It says, "Appropriately labels the data set with descriptive activity names." Does it mean name variables in the data set or the data set itself? Assuming that it is the later, the merged data frame is named as humanActivityofDailyLiving to properly indicate what it is. Nevertheless, I also use descriptive names for variables after the new data set is created.

### Calculate means:
=========================
The seventh section of code calculates means of the measurements for each subject and each activity using melt() and dcast().

### Label variables:
=========================
The eighth section of code labels the variables in the final data set by the following steps: 
* Obtain the variable names of extracted data and assign it to varsList
* Convert varsList into a data frame called varsListDF
* Read features from features.txt and convert the feature code to character
* Create a filter to retrieve the extracted variable names
* Use gsub() to eliminate unproper symbols in variable names

### Export the tify data set
=========================
The nineth section of code exports the data set to a text file. 

