require("plyr")
require("ggmap")
require("class")
require("googleVis")
require("RgoogleMaps")
require("e1071")
require("RMySQL")

con <- dbConnect(RMySQL::MySQL(), dbname = "proj_crime_data",host = "127.0.0.1",port=3306,user="root",password="XXX")
data<-dbGetQuery(con, "SELECT * FROM crime_info")

#data<-read.csv("G://Final project//data//a//crime_data.csv")
#data<-data[(c(5,6,11))]

qplot(latitude,longitude , data = data, colour = crime_type)
qmplot(longitude, latitude, data = (data), maptype = "toner-lite", color = crime_type, size = crime_type, legend = "topleft")
