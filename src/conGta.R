conGta<-function(){
  
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  con <- dbConnect(drv, url="jdbc:sqlserver://172.16.8.21", 
                   user="", password="")
  return(con)  
}
