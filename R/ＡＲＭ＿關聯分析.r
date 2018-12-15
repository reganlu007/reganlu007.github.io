library(data.table);library(magrittr);library(dplyr);library(arulesViz)

ARM  = function(x, s=.1, z=.8, n=30) inspect(head(sort(apriori(as.matrix(x), parameter=list(supp=s, conf=z)), by='support'), n))
SORT = function(x) data.table(table(x))[N>0][order(-N)]

# 樞紐分析
# 檢視 support = 0.01, confidence = 0.8 的關聯分析結果
ARM((tmp = dcast.data.table(fread('子宮肌瘤門診中藥_醫師.csv'), 門診號+批價日期+主治醫師代號~收費編號))[,c(-3,-2,-1)], .01)
ARM( tmp[grep('D31894D58D22CDECC5A55826F57B8DB1A6EE82CC',主治醫師代號)][,c(-3,-2,-1)], .01)
ARM( tmp[grep('3495F5EE004CF696D29F9FB0C0240EC3294EBFB9',主治醫師代號)][,c(-3,-2,-1)], .01)
ARM( tmp[grep('F01E3845A2DB53B44940D2E256DB96BC48FF1EFB',主治醫師代號)][,c(-3,-2,-1)], .01)

# 檢視 support = 0.1 , confidence = 0.8 的關聯分析結果
ARM((tmp = dcast.data.table(fread('子宮肌瘤住診中藥_醫師.csv'), 住院號+日期+醫師別~收費編號))[,c(-3,-2,-1)])
ARM( tmp[grep('E9385CAAB8C5A00B',醫師別)][,c(-3,-2,-1)])
ARM( tmp[grep('F4262C7C21D08356',醫師別)][,c(-3,-2,-1)])
ARM( tmp[grep('3941BF4DECDAE0F9',醫師別)][,c(-3,-2,-1)])
