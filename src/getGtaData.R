
ds<-getGtaData(code="A1701",t1="MFL1",t2="TRDMIN",f="60")

getGtaData<-function(code="000004.SZ",t1="SZL2",t2="TRADE",t3="SEL2",f="60",from="20161201",to="20161201",tf="tempData",...){
  if (toupper(t1)=="SEL1" & toupper(t2)=="TRDMIN"){
    sqlfn<-creatSeL1TrdMin(code,t1,t2,f,from,to,tf)
  }
  if (toupper(t1)=="SEL1" & toupper(t2)=="TAQ"){
    sqlfn<-creatSeL1TAQ(code,t1,t2,from,to,tf)
  }  
  if (toupper(t1)=="SZL2" & toupper(t2)=="TRADE"){
    sqlfn<-creatSzl2Trade(code,t1,t2,from,to,tf)
  } 
  if (toupper(t1)=="SHL2" & toupper(t2)=="TRANSACTION"){
    sqlfn<-creatShl2Transaction(code,t1,t2,t3,from,to,tf)
  } 
  if (toupper(t1)=="MFL1" & toupper(t2)=="TRDMIN"){
    sqlfn<-creatMfL1TrdMin(code,t1,t2,f,from,to,tf)
  } 
  
  allds<-list()
  allds<- Map(downData,sqlfn[[1]],sqlfn[[2]])
  allds<-do.call(rbind,allds)
  rownames(allds)<-NULL
  return(allds)
  
}



##


creatFt<-function(from,to){
  from<-as.Date(from,"%Y%m%d")
  to<-as.Date(to,"%Y%m%d")
  ft<-seq(from,to,by="month")
  ft<-format(ft,format="%Y%m")
}
creatSeL1TrdMin<-function(code,t1,t2,f,from,to,tf){
  
  if(substr(code,7,9)== ".SH") {
    local="SHL1"
  } else {local="SZL1"}
  ftList<-creatFt(from,to)
  sql<-vector(length =length(ftList) )
  fn<-vector(length =length(ftList) )
  for (i in seq_along(ftList)){ 
    #example:get GTA_SeL1_TrdMin_200903.dbo.SHL1_TRDMIN01_200903
    sql[i]<-paste0("select  * from GTA_",t1,"_",t2,"_",ftList[i],".dbo.",local,"_",t2,f,"_",ftList[i]," where seccode='",substr(code,1,6),"'")
    fn[i]<-paste0(tf,"/",local,"_",t2,f,"_",ftList[i],"_",substr(code,1,6),".rda")
  }
  return(list(sql,fn))
}
creatSeL1TAQ<-function(code,t1,t2,from,to,tf){
  #license end to 201612
  if(substr(code,7,9)== ".SH") {
    local="SHL1"
  } else {local="SZL1"}
  ftList<-creatFt(from,to)
  sql<-vector(length =length(ftList) )
  fn<-vector(length =length(ftList) )
  for (i in seq_along(ftList)){ 
    #example:GTA_SEL1_TAQ_201606.dbo.SZL1_TAQ_000001_201606
    
    sql[i]<-paste0("select  * from GTA_",t1,"_",t2,"_",ftList[i],".dbo.",local,"_",t2,"_",substr(code,1,6),"_",ftList[i])
    fn[i]<-paste0(tf,"/",local,"_",t2,"_",substr(code,1,6),"_",ftList[i],".rda")
  }
  return(list(sql,fn))
}
creatSzl2Trade<-function(code,t1,t2,from,to,tf){
  #t1="SZL2" t2="Trade"
  #license from 201612
  ftList<-creatFt(from,to)
  sql<-vector(length =length(ftList) )
  fn<-vector(length =length(ftList) )
  for (i in seq_along(ftList)){ 
    #example:GTA_SZL2_TRADE_201612.dbo.SZL2_TRADE_000001_201606
    sql[i]<-paste0("select  * from GTA_",t1,"_",t2,"_",
                   ftList[i],".dbo.",t1,"_",t2,"_",substr(code,1,6),"_",ftList[i])
    fn[i]<-paste0(tf,"/",t1,"_",t2,"_",substr(code,1,6),"_",ftList[i],".rda")
    
  }
  return(list(sql,fn))
}
creatShl2Transaction<-function(code,t1,t2,t3,from,to,tf){
  #t1="SHL2" t2="TRANSACTION",t3="SEL2"
  #license from 201612
  ftList<-creatFt(from,to)
  sql<-vector(length =length(ftList) )
  fn<-vector(length =length(ftList) )
  for (i in seq_along(ftList)){ 
    #example:GTA_SEL2_TRANSACTION_201612.dbo.SHL2_TRANSACTION_000001_201606
    sql[i]<-paste0("select  * from GTA_",t3,"_",t2,"_",
                   ftList[i],".dbo.",t1,"_",t2,"_",substr(code,1,6),"_",ftList[i])
    fn[i]<-paste0(tf,"/",t1,"_",t2,"_",substr(code,1,6),"_",ftList[i],".rda")
    
  }
  return(list(sql,fn))
}
creatMfL1TrdMin<-function(code,t1,t2,f,from,to,tf){
  #t1="MFL1" t2="TRDMIN"
  ftList<-creatFt(from,to)
  sql<-vector(length =length(ftList) )
  fn<-vector(length =length(ftList) )
  for (i in seq_along(ftList)){ 
    #example:GTA_MFL1_TrdMin_200308.dbo.MFL1_TRDMIN01_200308
    sql[i]<-paste0("select  * from GTA_",t1,"_",t2,"_",
                   ftList[i],".dbo.",t1,"_",t2,f,"_",ftList[i], " where CONTRACTID='",code,"'")
    fn[i]<-paste0(tf,"/",t1,"_",t2,"_",ftList[i],".rda")
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
  } else {
    try(ds<-dbGetQuery(con, getSql))
    dbDisconnect(con)
    print(paste0(fn," download"))
    save(ds,file=fn)
  }
  return(ds)
}
