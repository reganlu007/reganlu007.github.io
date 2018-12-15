library(data.table);library(magrittr);library(arulesViz)

門  = fread('門.csv');F_門 = function(x)門[grep(x, 主治醫師代號)][,c(-3,-2,-1)]
門1 = F_門('D31894D58D22CDECC5A55826F57B8DB1A6EE82CC')
門2 = F_門('3495F5EE004CF696D29F9FB0C0240EC3294EBFB9')
門3 = F_門('F01E3845A2DB53B44940D2E256DB96BC48FF1EFB')
門0 = 門[,c(-3,-2,-1)]

住  = fread('住.csv');F_住 = function(x)住[grep(x, 醫師別)][,c(-3,-2,-1)]
住1 = F_住('E9385CAAB8C5A00B')
住2 = F_住('F4262C7C21D08356')
住3 = F_住('3941BF4DECDAE0F9')
住0 = 住[,c(-3,-2,-1)]
ARM  = function(x, s=.1, z=.8, n=30) inspect(head(sort(apriori(as.matrix(x), parameter=list(supp=s, conf=z)), by='support'), n))
SORT = function(x) data.table(table(x))[N>0][order(-N)]

# 樞紐分析
# 檢視 support = 0.01, confidence = 0.8 的關聯分析結果
ARM(門0, .01)
ARM(門1, .01)
ARM(門2, .01)
ARM(門3, .01)

# 檢視 support = 0.1 , confidence = 0.8 的關聯分析結果
ARM(住0)
ARM(住1)
ARM(住2)
ARM(住3)
