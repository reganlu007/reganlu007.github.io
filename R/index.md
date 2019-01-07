#  子宮肌瘤
## 基本資料
```
library(data.table);library(magrittr)

icd_9 = '^218|^617|^6253|^6254|^626|^628'
住院申報 = fread('子宮肌瘤-呂豪笙\\住院申報費用清單.csv')
rbind(	住院申報[grep(icd_9,主疾病代號)],
	住院申報[grep(icd_9,疾病代號一)],
	住院申報[grep(icd_9,疾病代號二)],
	住院申報[grep(icd_9,疾病代號三)],
	住院申報[grep(icd_9,疾病代號四)]) %>% unique %>% fwrite('住院申報費用清單_icd_selected.csv')
門診歷史 = fread('子宮肌瘤-呂豪笙\\門診處方歷史檔.csv')
rbind(	門診歷史[grep(icd_9,疾病代號一)],
	門診歷史[grep(icd_9,疾病代號二)],
	門診歷史[grep(icd_9,疾病代號三)],
	門診歷史[grep(icd_9,疾病代號四)],
	門診歷史[grep(icd_9,疾病代號五)],
	門診歷史[grep(icd_9,疾病代號六)]) %>% unique %>% fwrite('門診處方歷史檔_icd_selected.csv')
rm(住院申報,門診歷史);gc()

no04 = function(x){
	f = function(x){
		y = unique(x[資料年月<200500][,3][[1]])
		x = unique(x[,3][[1]])
		x = data.table(x[!x %in% y])
		names(x)='歸戶代號'
		x
	}
	merge(f(x),x)
}
no04(fread(　'門診處方歷史檔_icd_selected.csv')) %>% fwrite(　'門診處方歷史檔_icd_selected_05_14.csv')
no04(fread('住院申報費用清單_icd_selected.csv')) %>% fwrite('住院申報費用清單_icd_selected_05_14.csv')

tmp1 = merge(unique(fread('住院申報費用清單_icd_selected_05_14.csv')[,5]),fread('子宮肌瘤-呂豪笙\\住診批價明細檔.csv'))
tmp2 = merge(unique(fread(　'門診處方歷史檔_icd_selected_05_14.csv')[,5]),fread('子宮肌瘤-呂豪笙\\門診批價明細檔.csv'))

# 拆分
x = unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5])
tmp2 =	rbind(
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_1.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_2.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_3.csv')))

view = function(x)data.table(table(x[grep('^7[B-Z]-',收費編號)]))[order(-N)]
view(tmp1[,7])
view(tmp2[,5])

### 之後使用 excel 處理 中藥收費ID
```
## 關聯分析
```
library(dplyr)
dcast(tmp1[grep('^7[B-Z]-',收費編號)], 住院號 + 批價日期 ~ 收費編號) %>% fwrite('住.csv')
dcast(tmp2[grep('^7[B-Z]-',收費編號)], 門診號 + 批價日期 ~ 收費編號) %>% fwrite('門.csv')

library(arulesViz)
arm = function(x,s=.1,z=.8,b='support')sort(apriori(data.matrix(x),parameter=list(supp=s,conf=z)),by=b)
arm(fread('門.csv')[,c(-2,-1)], s=.01) %>% head(30) %>% inspect
arm(fread('住.csv')[,c(-2,-1)]) %>% head(30) %>% inspect
```
## 網絡分析
```
library(igraph)
sna = function(x,w=T,m='undirected'){x[x>=1]=1;simplify(graph.adjacency(t(x%<>%data.matrix)%*%x,weighted=w,mode=m))}
cop = function(g,m=cluster_optimal(g),v=degree(g),e=E(g)$weight,l=layout.circle)plot(m,g,vertex.size=v,edge.width=e,layout=l)
sna(fread('門.csv')[,c(-2,-1)])
sna(fread('住.csv')[,c(-2,-1)])
```
