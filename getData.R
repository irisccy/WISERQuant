#RJDBC 
getGTA<-function(code="RB1701",from="201701",to="201702",type="MF",f="TRDMIN",l="L1"){
  #code:RB1701
  #from: 201701
  #to: 201702
  #type:MF
  #f:TRDMIN
  #l:L1 L2
  
  library(RJDBC)
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  con <- dbConnect(drv, url="jdbc:sqlserver://xx.xx.xx.xx", user="xx", password="xx",dbname="GTA_MFL1_TRDMIN_201701")
  getSql<-"select top 10000 * from GTA_MFL1_TRDMIN_201701.dbo.MFL1_TRDMIN01_201701 where contractid='RB1701'"
  ds<-dbGetQuery(con, getSql)
  dbDisconnect(con)
  return(ds)
  
  
}
getLevel2Test<-function(){
  library(RJDBC)
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  con <- dbConnect(drv, url="jdbc:sqlserver://210.34.5.41", user="gta", password="gta",dbname="GTA_MFL1_TRDMIN_201701")
  getSql<-"select top 10000 * from GTA_MFL1_TRDMIN_201701.dbo.MFL1_TRDMIN01_201701 where contractid='RB1705'"
  ds<-dbGetQuery(con, getSql)
  dbDisconnect(con)
  return(ds)
  
  
}

#sample 
s0102<-getData("000010",201610,201610)
