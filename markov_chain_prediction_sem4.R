require("RMySQL")
con <- dbConnect(RMySQL::MySQL(), dbname = "semester4",
                 host = "127.0.0.1",port=3307,
                 user="root")
data<-dbGetQuery(con, 'SELECT * from student
                 natural join  sunday_1before natural join monday_1before
                 natural join tuesday_1before natural join wednesday_1before
                 natural join thursday_1before natural join friday_1before
                 natural join saturday_1before')


head(data,1)
data<-data[c(-1,-2)]
data
data[1,2]
subject<-data.frame(subject1="",subject2="",stringsAsFactors=FALSE)
subject

nrow(data)

for(data_row in 1:nrow(data)){
  
  row<-unname(unlist(data[data_row,]))
  row
  length(row)
  row
  tpm<- matrix(c(0),nrow = 4, ncol = 4,byrow=TRUE,
               dimnames = list(c("MP","OS","DBMS","maths"),
                               c("MP","OS","DBMS","maths")))
  
  for (t in 1:(length(row) - 1)) 
  {  
    #print(c(as.character(row[t]),as.character(row[t+1])));
    
    tpm[as.character(row[t]), as.character(row[t + 1])] <- tpm[as.character(row[t]), as.character(row[t + 1])] + 1
  }
  tpm[as.character(row[length(row)]),as.character(row[1])]<-tpm[as.character(row[length(row)]),as.character(row[1])]+1
  
  for (i in 1:4) tpm[i, ] <- tpm[i, ] / sum(tpm[i, ])
  tpm
  
  # construct concentration matrix
  req_dat_concen<-data[c(17:28)]
  head(req_dat_concen)
  req_dat_concen
  con_row<-unname(unlist(req_dat_concen[data_row,]))
  length(con_row)
  con_row
  con_matrix<- matrix(c(0),nrow = 1, ncol = 4,byrow=TRUE,
                      dimnames = list(c("pro"),c("MP","OS","DBMS","maths")))
  for (t in 1:(length(con_row))) 
    con_matrix[1,as.character(con_row[t])]<-con_matrix[1,as.character(con_row[t])]+1
  con_matrix[1, ] <- con_matrix[1, ] / sum(con_matrix[1, ])
  con_matrix
  tpm
  #find result
  result<-con_matrix %*% tpm
  ascend<-order(result)
  print(ascend)
  subject[data_row,1]<-ifelse(ascend[1]==1,"MP",
                              ifelse(ascend[1]==2,"OS",
                                     ifelse(ascend[1]==3,"DBMS","maths")))
  subject[data_row,2]<-ifelse(ascend[2]==1,"MP",
                              ifelse(ascend[2]==2,"OS",
                                     ifelse(ascend[2]==3,"DBMS","maths")))
}
subject
