setwd("./Cleaning data/project")

//read data into R objects
xSubjectTrainData <- read.table("./data/train/subject_train.txt",sep="")
yTrainData <- read.table("./data/train/y_train.txt",sep="")
xTrainData <- read.table("./data/train/X_train.txt",sep="")

xSubjectTestData <- read.table("./data/test/subject_test.txt",sep="")
yTestData <- read.table("./data/test/y_test.txt",sep="")
xTestData <- read.table("./data/test/X_test.txt",sep="")

//merge two data frames of measurements, subjects, activities into ones
measureData <- rbind(xTrainData, xTestData)

subjectData <- rbind(xSubjectTrainData,xSubjectTestData)
colnames(subjectData) <- c("subject")

activityData <- rbind(yTrainData,yTestData)
colnames(activityData) <- c("code")

//convert activity code to descriptive names
conversion <- function(x) ifelse(x==1,"walking",
                                 ifelse(x==2,"walking upstairs",
                                  ifelse(x==3,"walking downstairs",
                                  ifelse(x==4,"sitting",
                                  ifelse(x==5,"standing","laying")))))

activityData$activity <- conversion(activityData$code)

//create a vector of variables which are means and standard deviations
varsNeeded <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)
extractedData <- measureData[varsNeeded]
varsList <- names(extractedData)

//merge subject, activities, and extracted measurements 
humanActivityofDailyLiving <- cbind(subjectData,activityData,extractedData)


//Calculate mean for each subject and each activity

library(reshape2)
projectDataMelt <- melt(humanActivityofDailyLiving,id=colnames(humanActivityofDailyLiving),measure.vars=varsList)
meanData <- dcast(projectDataMelt, subject + activity ~ variable, mean)

//Use descriptive names for variables
featureData <- read.table("./data/features.txt",sep="")

varsListDF <- data.frame(varsList)
varsListDF$code <- sub("V","",varsListDF$varsList,)
featureData$V1 <- as.character(featureData$V1)

filter <-  featureData$V1 %in% varsListDF$code
filteredFeature <- featureData[filter,]
names(filteredFeature) <-c("code","var")

filteredFeature$var <- gsub("Acc","Acceleration",filteredFeature$var)
filteredFeature$var <- gsub("\\()","",filteredFeature$var)
filteredFeature$var <- gsub("-mean","Mean",filteredFeature$var)
filteredFeature$var <- gsub("-std","STD",filteredFeature$var)
filteredFeature$var <- gsub("Mag","Magnitude",filteredFeature$var)
filteredFeature$var <- gsub("fBodyBody","fBody",filteredFeature$var)
filteredFeature$var <- gsub("-","",filteredFeature$var)

names(meanData) <- c("subject","activity",filteredFeature$var)

//export the data set to a text file
write.table(meanData,file="./data/averageforActivtyandSubject.txt")

