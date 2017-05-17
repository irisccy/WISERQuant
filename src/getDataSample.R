#sample code 
source("src/getGtaData.r")
source("src/conGta.r")
#Please contact your teacher to get the user name and passd in conGta.R

#get commodity futures trade minute data
#t1="MFL1" t2="TRDMIN" 
ds<-getGtaData(code="A1705",t1="MFL1",t2="TRDMIN",f="05",from="20170101",to="20170201")

#get stock trade minute data
#t1="SEL1" t2="TRDMIN"
ds<-getGtaData(code="000858.SZ",t1="SEL1",t2="TRDMIN",f="60",from="20170101",to="20170201")

#get ShenZhen stock transaction L2 data (by each order number)
#t1="SZL2" t2="Trade"
ds<-getGtaData(code="000858.SZ",t1="SZL2",t2="Trade",from="20170101",to="20170201")

#get ShangHai stock transaction L2 data (by each order number)
#t1="SHL2" ,t2="TRANSACTION",t3="SEL2"
ds<-getGtaData(code="600104.SH",t1="SHL2" ,t2="TRANSACTION",t3="SEL2",from="20170101",to="20170201")

#get stock TAQ data
#t1="SEL1" ,t2="TAQ"
#data license end in 2016-12-31
ds<-getGtaData(code="600104.SH",t1="SEL1" ,t2="TAQ",from="20160101",to="20161231")

