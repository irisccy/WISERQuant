#sample code 
source("src/getGtaData.r")
source("src/conGta.r")
#请联系相关老师获得conGta.r文件中的用户名及密码

#获取期货分钟交易数据
#t1="MFL1" t2="TRDMIN" 
ds<-getGtaData(code="A1705",t1="MFL1",t2="TRDMIN",f="05",from="20170101",to="20170201")

#获取股票分钟交易数据
#t1="SEL1" t2="TRDMIN"
ds<-getGtaData(code="000858.SZ",t1="SEL1",t2="TRDMIN",f="60",from="20170101",to="20170201")

#获取深圳市场股票高频逐笔交易数据
#t1="SZL2" t2="Trade"
ds<-getGtaData(code="000858.SZ",t1="SZL2",t2="Trade",from="20170101",to="20170201")

#获取上海市场股票高频逐笔交易数据
#t1="SHL2" ,t2="TRANSACTION",t3="SEL2"
ds<-getGtaData(code="600104.SH",t1="SHL2" ,t2="TRANSACTION",t3="SEL2",from="20170101",to="20170201")

#获取股票市场TAQ交易数据
#t1="SEL1" ,t2="TAQ"
ds<-getGtaData(code="600104.SH",t1="SEL1" ,t2="TAQ",from="20160101",to="20161231")

