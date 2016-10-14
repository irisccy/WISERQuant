#RJDBC
getData<-function(stock,from,to){
library(RJDBC)
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  con <- dbConnect(drv, url="jdbc:sqlserver://172.16.8.48", user="stock", password="wisesoe.002",dbname="tempdata")
  getSql<-paste0("tempdata..get_data ", "'",stock,"'",',',"'",from,"'",',',"'",to,"'")
  ds<-dbGetQuery(con, getSql)
  dbDisconnect(con)
  return(ds)
}

#sample 
#getData("000001",201601,201609)
