require("plyr")
require("ggmap")
require("class")
require("googleVis")
require("RgoogleMaps")
require("e1071")
con <- dbConnect(RMySQL::MySQL(), dbname = "proj_crime_data",host = "127.0.0.1",port=3306,user="root",password="XXX")
data1<-dbGetQuery(con, "SELECT * FROM crime_info where (crime_type!='public order') and (crime_type!='Bicycle theft') and (crime_type!='Anti-social behaviour') and (crime_type!='Theft from the person') and (crime_type!='Other theft') and (crime_type!='vehicle crime') limit 83")
data2<-dbGetQuery(con, "SELECT * FROM crime_info where (crime_type='Anti-social behaviour') limit 17" )

info_needed<-(rbind(data1,data2))
info_needed<-info_needed[c(5,4,3)]
info_needed
model <- naiveBayes(crime_type ~ ., data = info_needed, laplace=3)
pred <- predict(model, info_needed)
pred
table(pred, info_needed$crime_type)
model
(info_needed[100,-3])

predict(model, info_needed[100,-3])
a
plot(model$apriori)
?naiveBayes
?predict
data(Titanic)
(Titanic)
m <- naiveBayes(Survived ~ ., data = Titanic)
m
predict(m, as.data.frame(Titanic))
