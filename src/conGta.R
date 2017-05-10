library(RJDBC)
conGta<-function(){
  
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  con <- dbConnect(drv, url="jdbc:sqlserver://172.16.8.21", 
                   user="gta", password="gta",
                   dbname=paste0("GTA_",loca1,lv,"_",table,"_",ft[i]))
  return(con)  
}
