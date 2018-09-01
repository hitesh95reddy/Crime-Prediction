require("plyr")
require("ggmap")
require("class")
require("googleVis")
require("RgoogleMaps")
require("e1071")
require("RMySQL")

con <- dbConnect(RMySQL::MySQL(), dbname = "proj_crime_data",host = "127.0.0.1",port=3306,user="root",password="XXX")
data2<-dbGetQuery(con, "SELECT * FROM crime_info")


test2<-(data2)
p<-count(test2, c("DATE","crime_type"))
ef<-merge(test2, p, by=c("DATE","crime_type"), all.x=TRUE)
ef$latlong<-paste(ef$latitude, ef$longitude, sep=":")
G6 <- gvisGeoChart(ef,"latlong",colorvar="freq",sizevar='freq',hover="location",options=list(width=600, height=600,enableScrollWheel=TRUE) )
plot(G6)
G7<-gvisGeoMap(ef,locationvar='latlong',numvar='freq',hovervar='crime_type',options=list(width=800,height=400,region='GB',dataMode='Markers'))
plot(G7)

