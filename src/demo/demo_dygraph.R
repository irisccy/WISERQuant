library(dygraphs)
load(file = "src/demo/demo_dygraph.rda")
ds<-as.xts(ds)
class(ds)
ds_temp<-ds['2016-09-01/2016-09-03']
p<-dygraph(ds_temp[,1:6]) %>%
  dyCandlestick() %>%
  dyRangeSelector(height = 10, strokeColor = "")
p
