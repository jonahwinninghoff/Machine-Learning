## Download and obtain training and testing files
download.file(
  "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",
  destfile = "training",method = "curl",
  na.strings=c("NA","#DIV/0!","")))
training <- read.csv("training", header = TRUE, 
  na.strings=c("NA","#DIV/0!",""))

## Move testing aside for second cross-validation purpose.
testing <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", 
  header = TRUE, na.strings=c("NA","#DIV/0!",""))

## Obtain tools and set up the mytraining and mytesting
## from training
library(caret); library(rattle); library(rpart) 
library(randomForest);library(ggplot2);library(lattice)

inTrain <- createDataPartition(training$classe, p=.7,
  list=FALSE)
mytesting <- training[-inTrain,]
mytraining <- training[inTrain,]

## Clean up the dataset
library(dplyr)
select(mytraining,2:5,7:11,37:49,60:68,84:86,102,
  113:124,140,151:160)->Tidymytraining
select(mytesting,2:5,7:11,37:49,60:68,84:86,102,
  113:124,140,
  151:160)->Tidymytesting ## Done so without looking inside
## Exploratory data analysis on training
featurePlot(x=Tidymytraining[,6:57], y = Tidymytraining,plot="pairs")
