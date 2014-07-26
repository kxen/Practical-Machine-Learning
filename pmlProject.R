
library(caret)

# set working directory to the directory the training and test sets are located.
#setwd("./")
pmlTraining<-read.csv("./pml-training.csv")
pmlTesting<-read.csv("./pml-testing.csv")

#locate all variables related to accelerometer characteristic
sensorBelt<-grep("accel_belt|accel_belt_",names(pmlTraining))
sensorArm<-grep("accel_arm|accel_arm_",names(pmlTraining))
sensorDumbbell<-grep("accel_dumbbell|accel_dumbbell_",names(pmlTraining))
sensorForeArm<-grep("accel_forearm|accel_forearm_",names(pmlTraining))

#remove the variance of each parameter related to accelerometer since 98% of the data is missing
predictors=names(pmlTraining)[c(sensorBelt[-2],sensorArm[-2],sensorDumbbell[-2],sensorForeArm[-2])]

pmlTrainingMod<-pmlTraining[,c(predictors,"classe")]
pmlTestingMod<-pmlTesting[,c(predictors)]

modFit<-train(classe~.,data=pmlTrainingMod,method="rf",trControl=trainControl(method="oob"),importance=TRUE)

#Figures plots
#layout(matrix(c(1,2),nrow=1),width=c(4,1)) 
#par(mar=c(5,4,4,1))
#plot(modFit$finalModel,main="Random Forest Classification")
#par(mar=c(5,0,4,2))
#plot(c(0,1),type="n", axes=F, xlab="", ylab="")
#legend("top", legend=colnames(modFit$finalModel$err.rate),col=1:6,cex=0.8,fill=1:6)

#varImpPlot(modFit$finalModel)
