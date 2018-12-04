library(data.table);library(magrittr);library(dplyr);library(arulesViz)

# 製作關聯分析方法，依 support 大至小排序
ARM  = function(x, s, z)inspect(head(sort(apriori(as.matrix(x), parameter=list(supp=s, conf=z)),by='support'),30))

# 執行單變量記數
SORT = function(x) data.table(table(x))[N>0][order(-N)]

# 檢視單變量記數
VIEW = function(x) View(SORT(x))

# 樞紐分析表
tmp = dcast(merge(unique(門診批價基本檔[,c(5,7)]),子宮肌瘤門診中藥), 門診號+批價日期+主治醫師代號~收費編號)
tmp
tmp = dcast(merge(unique(住診批價基本檔[,c(4,7)]),子宮肌瘤住診中藥), 住院號+日期+醫師別~收費編號)
tmp

# 檢視 support = 0.01, confidence = 0.8 的關聯分析結果

ARM(tmp[,c(-3,-2,-1)], .01, .8)
ARM(tmp[grep(門診醫師計數[1,1],主治醫師代號)][,c(-3,-2,-1)], .01, .8)
ARM(tmp[grep(門診醫師計數[2,1],主治醫師代號)][,c(-3,-2,-1)], .01, .8)
ARM(tmp[grep(門診醫師計數[3,1],主治醫師代號)][,c(-3,-2,-1)], .01, .8)

# 檢視 support = 0.1 , confidence = 0.8 的關聯分析結果

ARM(tmp[,c(-3,-2,-1)], .1 , .8)
ARM(tmp[grep(住院醫師計數[1,1],醫師別)][,c(-3,-2,-1)], .1 , .8)
ARM(tmp[grep(住院醫師計數[2,1],醫師別)][,c(-3,-2,-1)], .1 , .8)
ARM(tmp[grep(住院醫師計數[3,1],醫師別)][,c(-3,-2,-1)], .1 , .8)
