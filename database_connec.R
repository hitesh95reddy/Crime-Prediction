require("RMySQL")
con <- dbConnect(RMySQL::MySQL(), dbname = "proj_crime_data",host = "127.0.0.1",port=3306,user="root",password="Hi123321")
dbGetQuery(con, "SELECT * FROM crime_info limit 3")
