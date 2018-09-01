require("plyr")
require("ggmap")
require("class")
require("googleVis")
require("RgoogleMaps")
require("e1071")
require("RMySQL")

con <- dbConnect(RMySQL::MySQL(), dbname = "proj_crime_data",host = "127.0.0.1",port=3306,user="root",password="XXX")
data<-dbGetQuery(con, "SELECT * FROM crime_info where (crime_type!='Anti-social behaviour') and (crime_type!='Other theft') limit 52")
(data)

train<-data[c(4,5)]
head(train)
lab<-data$crime_type
lat<-runif(10,52,54)
lon<- runif(10,-3,-2)
test<-data.frame(latitude=lat,longitude=lon)
ans<-test
head(test)

ans$prediction<-(knn(train,test ,lab, k = 4, prob=TRUE))
ans$probability<-attr((knn(train,test ,lab, k = 3, prob=TRUE)), 'prob')
ans$textAddress <- mapply(FUN = function(lon, lat) revgeocode(c(lon, lat)), ans$longitude, ans$latitude)
ans
#test
#tested<-ans
#tested
#an <- mapply(FUN = function(lon, lat) revgeocode(c(-2.2473371, 51.51291)))
#revgeocode(c(-2.2473371, 51.51291))

