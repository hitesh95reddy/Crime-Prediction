require("plyr")
require("ggmap")
require("class")
require("googleVis")
require("RgoogleMaps")
require("e1071")
require("RMySQL")

con <- dbConnect(RMySQL::MySQL(), dbname = "proj_crime_data",host = "127.0.0.1",port=3306,user="root",password="XXX")
data2<-dbGetQuery(con, "SELECT * FROM crime_info")

test2=data2
p<-count(test2, c("DATE","crime_type"))
center_lat=(median(data2$latitude ))
center_long=(median(data2$longitude ))
ef<-merge(test2, p, by=c("DATE","crime_type"), all.x=TRUE)
max(ef$freq)
map <- GetMap(center=c(center_lat,center_long), zoom=11,size=c(640,640),destfile = file.path(tempdir(),"meuse.png"),maptype="mobile", SCALE = 1);
bubbleMap(ef, coords = c("longitude","latitude"), map=map,zcol='freq', key.entries = 100+ 100 * c(10,20,30,40,50))
