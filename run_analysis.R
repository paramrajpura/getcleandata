#reading features names and features from train and test
d1<-read.table('features.txt')
d2<-read.table('train/X_train.txt')
d3<-read.table('test/X_test.txt')

#reading labels(activities) from train and test
d4<-read.table('train/y_train.txt')
d5<-read.table('test//y_test.txt')

#reading corresponding subjectID from train and test
d6<-read.table('train/subject_train.txt')
d7<-read.table('test//subject_test.txt')

#combining whole data in to single object
d2<-cbind(rbind(d6,d7),rbind(d2,d3),rbind(d4,d5))

#adding variable names to each column
d11<-as.character(d1$V2)
d11<-c("SubjectID",d11,"TypeofActivity")
names(d2)<-d11
#End of PART1


#Removing variables without mean and std
m<-grep("mean\\(\\)|std\\(\\)", names(d2), perl=TRUE,value=TRUE)
d2<-d2[,c("SubjectID",m,"TypeofActivity")]
#End of PART2

#Adding descriptive labels
actvt<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
d2$TypeofActivity<-factor(d2$TypeofActivity,labels=actvt)
#End of PART3

#Modifying unreadable variable names 
names(d2)<-gsub("-|\\()","",names(d2))
#End of PART4

#Obtaining mean for each subject and activity
data<-data.table(d2)
attach(data)
newdata <- aggregate(data, by = list(TypeofActivity,SubjectID), FUN = "mean")
detach(data)

newdata<-newdata[1:69]
newdata<-newdata[-2]
names(newdata)[1]<-"TypeofActivity"
#End of PART5

#Generating txt file
write.table(newdata,file="data.txt",row.names = FALSE)