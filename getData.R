#RJDBC
getData<-function(stock,from,to){
library(RJDBC)
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  #con COPY INTO HERE
  
  # END OF COPY INTO HERE
   getSql<-paste0("tempdata..get_data ", "'",stock,"'",',',"'",from,"'",',',"'",to,"'")
  ds<-dbGetQuery(con, getSql)
  dbDisconnect(con)
  return(ds)
}
