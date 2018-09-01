require("plyr")
require("ggmap")
require("class")
require("googleVis")
require("RgoogleMaps")
require("e1071")
require("RMySQL")

con <- dbConnect(RMySQL::MySQL(), dbname = "proj_crime_data",host = "127.0.0.1",port=3306,user="root",password="XXX")
data<-dbGetQuery(con, "SELECT * FROM crime_info")

info_needed<-data

latlong<-data.frame(latlong=paste(info_needed$latitude , info_needed$longitude , sep = ":"))

info<-data.frame(info=paste(data$location," ,","crime:",data$crime_type,sep=""))

plotdata<-data.frame(places=info_needed$location,latlong=latlong,info=info$info)
sites<-gvisMap(plotdata,locationvar="latlong",tipvar="info",options = list(displayMode="Markers",mapType="hybrid", enableScrollWheel=TRUE))

plot(sites)
head(data)
