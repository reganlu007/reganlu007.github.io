library(data.table);library(magrittr);library(dplyr);library(arulesViz)

# 製作關聯分析方法，依 support 大至小排序
ARM  = function(x, s=.1, z=.8, n=30) inspect(head(sort(apriori(as.matrix(x), parameter=list(supp=s, conf=z)), by='support'), n))

# 單變量記數
SORT = function(x) data.table(table(x))[N>0][order(-N)]

# 樞紐分析
# 檢視 support = 0.01, confidence = 0.8 的關聯分析結果
ARM((tmp = dcast.data.table(fread('子宮肌瘤門診病患_05_14.csv'), 門診號+批價日期+主治醫師代號~收費編號))[,c(-3,-2,-1)], .01, .8)
ARM( tmp[grep(門診醫師計數[1,1],主治醫師代號)][,c(-3,-2,-1)], .01, .8)
ARM( tmp[grep(門診醫師計數[2,1],主治醫師代號)][,c(-3,-2,-1)], .01, .8)
ARM( tmp[grep(門診醫師計數[3,1],主治醫師代號)][,c(-3,-2,-1)], .01, .8)

# 檢視 support = 0.1 , confidence = 0.8 的關聯分析結果
ARM((tmp = dcast.data.table(fread('子宮肌瘤住診病患_05_14.csv'), 住院號+日期+醫師別~收費編號))[,c(-3,-2,-1)])
ARM( tmp[grep(住院醫師計數[1,1],醫師別)][,c(-3,-2,-1)])
ARM( tmp[grep(住院醫師計數[2,1],醫師別)][,c(-3,-2,-1)])
ARM( tmp[grep(住院醫師計數[3,1],醫師別)][,c(-3,-2,-1)])
