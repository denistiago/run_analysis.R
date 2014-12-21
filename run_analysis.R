### ------------------------------------------------------------------------------------------------
### ---- script for creating a tidy data set
### ---- prepared for Getting and Cleaning Data, Coursera course
### ---- see README.md for more information
### ---- **NOTE: Data is assumed to be located in the working directory
### ------------------------------------------------------------------------------------------------

## ---- require packages
if (!require("data.table")) {install.packages("data.table")
                             require("data.table")}
if (!require("reshape2")) {install.packages("reshape2")
                           require("reshape2")}

## ---- read data from txt. NOTE: the data must exist in the paths used below
## ---- dir paths formatted for windows
folder.dir  <- 'UCI HAR Dataset'
test.path   <- paste(getwd(), folder.dir, 'test/', sep = '/')
train.path  <- paste(getwd(), folder.dir, 'train/', sep = '/')

train.x     <- read.table(paste(train.path, 'X_train.txt', sep = ''))
test.x      <- read.table(paste(test.path, 'X_test.txt', sep = ''))
train.y     <- read.table(paste(train.path, 'y_train.txt', sep = ''))
test.y      <- read.table(paste(test.path, 'y_test.txt', sep = ''))
test.subj   <- read.table(paste(test.path, 'subject_test.txt', sep = ''))
train.subj  <- read.table(paste(train.path, 'subject_train.txt', sep = ''))

act.labs    <- read.table(paste(getwd(), folder.dir, 'activity_labels.txt', sep = '/'))
features    <- read.table(paste(getwd(), folder.dir, 'features.txt', sep = '/'))
         

## ---- merge the test and train subj
subj <- rbind(test.subj, train.subj)
colnames(subj) <- 'subject'

## ---- merge the test and train y with act.labs
activity <- rbind(test.y, train.y)
activity <- merge(activity, act.labs, by=1)[,2]

## ---- merge the test and train x with features
merge.x <- rbind(test.x, train.x)
colnames(merge.x) <- features[, 2]

## ---- combine x,y data sets
merge.xy <- cbind(subj, activity, merge.x)

## ---- get mean and stdv features
merge.xy.stat <- merge.xy[ ,c(1, 2, grep('-mean|-std', colnames(merge.xy)))]


View(merge.xy.stat)
# compute means grouped by subject and activity
melt.xy = melt(merge.xy.stat, id.var = c('subject', 'activity'))
stat.mean = dcast(melt.xy , subject + activity ~ variable, mean)

# Save the resulting dataset
write.table(stat.mean, file="FinalData.txt")

# view the final dataset
View(stat.mean)
