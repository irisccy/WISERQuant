
#获取逐笔成交数据
#深市TRADE表
#沪市TRANSACTION表

getL2Trade<-function(code,lv="L2",from="20161201",to="20170301"){
  
  if(substr(code,7,9)== ".SH") {
    loca1="SE"
    loca2="SH"
    table="TRANSACTION"
  } else {
    loca1="SZ"
    loca2="SZ"
    table="TRADE"
  }
  tf<-"tempData"
  if (!file.exists(tf)){
    dir.create(tf)
  } 
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  from<-as.Date(from,"%Y%m%d")
  to<-as.Date(to,"%Y%m%d")
  ft<-seq(from,to,by="month")
  ft<-format(ft,format="%Y%m")
  allds<-data.frame()
  for (i in seq_along(ft)){
    con <- dbConnect(drv, url="jdbc:sqlserver://172.16.8.21", 
                     user=" ", password=" ",
                     dbname=paste0("GTA_",loca1,lv,"_",table,"_",ft[i]))
    getSql<-paste0("select  * from GTA_",loca1,lv,"_",table,"_",
                   ft[i],".dbo.",loca2,lv,"_",table,"_",substr(code,1,6),"_",ft[i])
    fn<-paste0(tf,"/",loca2,lv,"_",table,"_",substr(code,1,6),"_",ft[i],".rda")
    
    if (file.exists(fn)){
      load(fn)
      print(paste0(fn," exist"))
    } else {
      try(ds<-dbGetQuery(con, getSql))
      dbDisconnect(con)
      print(paste0(fn," download"))
      save(ds,file=fn)
      
    }
    allds<-rbind(allds,ds)
    
    
    #需要检查字段是否匹配
  }
  
  return(allds)
  
}

#获取逐笔成交数据
#深市TRADE表
#沪市TRANSACTION表
getL2Order<-function(code,lv="L2",from="20161201",to="20170301"){
  
  if(substr(code,7,9)== ".SH") {
    loca1="SE"
    loca2="SH"
    return(NULL)
  } else {
    loca1="SZ"
    loca2="SZ"
    table="Order"
  }
  tf<-"tempData"
  if (!file.exists(tf)){
    dir.create(tf)
  } 
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  from<-as.Date(from,"%Y%m%d")
  to<-as.Date(to,"%Y%m%d")
  ft<-seq(from,to,by="month")
  ft<-format(ft,format="%Y%m")
  allds<-data.frame()
  for (i in seq_along(ft)){
    con <- dbConnect(drv, url="jdbc:sqlserver://172.16.8.21", 
                     user=" ", password=" ",
                     dbname=paste0("GTA_",loca1,lv,"_",table,"_",ft[i]))
    getSql<-paste0("select  * from GTA_",loca1,lv,"_",table,"_",
                   ft[i],".dbo.",loca2,lv,"_",table,"_",substr(code,1,6),"_",ft[i])
    fn<-paste0(tf,"/",loca2,lv,"_",table,"_",substr(code,1,6),"_",ft[i],".rda")
    
    if (file.exists(fn)){
      load(fn)
      print(paste0(fn," exist"))
    } else {
      try(ds<-dbGetQuery(con, getSql))
      dbDisconnect(con)
      print(paste0(fn," download"))
      save(ds,file=fn)
      
    }
    allds<-rbind(allds,ds)
    
    
    #需要检查字段是否匹配
  }
  
  return(allds)
  
}

getGta...Data<-function(){
  
}