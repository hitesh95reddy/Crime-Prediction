
a=read.csv("G://Final project//data//a//crime_data.csv")
head(a)
test2<-(a[c(2,5,6,7,11)])
head(test2)
test2$DATE<-as.Date((as.character(substring(test2$Month,1,10))))
head(test2)
test2<-test2[c(6,5,3,2,4)]
head(test2)
getwd()
write.csv(test2,"b.csv",col.names = TRUE)
head((test2))
