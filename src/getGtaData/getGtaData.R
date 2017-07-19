options(java.parameters = "-Xmx8048m")

library("RJDBC")
getGtaData<-function(code="000004",loc="SZ",dbLev="L2",db="TAQ",f="60",from="20161201",to="20161201",tf="tempData",...){
  
  if (toupper(loc)=="SZ" & toupper(dbLev)=="L2" & toupper(db)=="TAQ" ){
    sqlfn<-creatSZL2TAQ(code,loc,dbLev,db,from,to,tf)
  }
  if (toupper(loc)=="SH" & toupper(dbLev)=="L2" & toupper(db)=="TAQ" ){
    sqlfn<-creatSHL2TAQ(code,loc,dbLev,db,from,to,tf)
  }
  
  allds<-list()
  allds<- Map(downData,sqlfn[[1]],sqlfn[[2]])
  #allds<-do.call(rbind,allds)
  #rownames(allds)<-NULL
  return(allds)
  
}


creatSZL2TAQ<-function(code,loc,dbLev,db,from,to,tf){
  ftList<-creatFt(from,to)
  sql<-vector(length =length(ftList) )
  fn<-vector(length =length(ftList) )
  for (i in seq_along(ftList)){ 

    #example:get GTA_SZL2_TAQ_200903.dbo.SZL2_TAQ_000858_200903
    sql[i]<-paste0("select * from GTA_",loc,dbLev,"_",db,"_",ftList[i],".dbo.",loc,dbLev,"_",db,"_",code,"_",ftList[i])
    print(sql[i])
    fn[i]<-paste0(tf,"/",loc,dbLev,"_",ftList[i],"_",code,".rda")
  }
  return(list(sql,fn))
}
creatSHL2TAQ<-function(code,loc,dbLev,db,from,to,tf){
  ftList<-creatFt(from,to)
  sql<-vector(length =length(ftList) )
  fn<-vector(length =length(ftList) )
  for (i in seq_along(ftList)){ 
    #example:get GTA_SHL2_TAQ_200903.dbo.SHL2_TAQ_600104_200903
    sql[i]<-paste0("select * from GTA_","SE",dbLev,"_",db,"_",ftList[i],".dbo.",loc,dbLev,"_",db,"_",code,"_",ftList[i])
    print(sql[i])
    fn[i]<-paste0(tf,"/",loc,dbLev,"_",ftList[i],"_",code,".rda")
  }

  return(list(sql,fn))
}

downData<-function(getSql,fn){
  
  tf<-"tempData"
  if (!file.exists(tf)){
    dir.create(tf)
  }   
  con<-conGta()
  if (file.exists(fn)){
    load(fn)
    print(paste0(fn," exist"))
    #如果是当月数据，需要重新下载
    currentMonth<-format(Sys.Date(),format="%Y%m")
    if (grepl(currentMonth,fn)){
      try(ds<-dbGetQuery(con, getSql))
      dbDisconnect(con)
      print(paste0(fn," Current Month Redownload"))
      save(ds,file=fn)
    }
  } else {
   
    try(ds<-dbGetQuery(con, getSql))
    dbDisconnect(con)
    print(paste0(fn," download"))
    save(ds,file=fn)
  }
  return(ds)
}
creatFt<-function(from,to){
  from<-as.Date(from,"%Y%m%d")
  to<-as.Date(to,"%Y%m%d")
  ft<-seq(from,to,by="month")
  ft<-format(ft,format="%Y%m")
}
conGta<-function(){
  
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","sqljdbc4.jar")
  con <- dbConnect(drv, url="jdbc:sqlserver://172.16.8.21", 
                   user=" ", password=" ")
  return(con)  
}

ds<-getGtaData(code="600104",loc="SH",dbLev="L2",db="TAQ",
               from="20170601",to="20170701",tf="tempData")


