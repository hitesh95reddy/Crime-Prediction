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
tail(test2)
test2$Year<-as.Date((as.character(substring(test2$DATE,1,10))))
p<-count(test2,c("Year","crime_type"))


M <- gvisMotionChart(p, "crime_type", "Year", date.format = "\\%Y\\%m\\%d")
plot(M)

