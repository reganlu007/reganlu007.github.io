#  子宮肌瘤
## 匯入函數
```
library(data.table);library(magrittr);library(dplyr);library(arulesViz);library(igraph)
```
## 基本資料
```
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

no04 =	function(x){
	y = unique(x[資料年月<200500][,3][[1]])
	z = unique(x[,3][[1]])
	w = data.table(z[!z %in% y])
	names(w)='歸戶代號'
	merge(w,x)
}
no04(fread(　'門診處方歷史檔_icd_selected.csv')) %>% fwrite(　'門診處方歷史檔_icd_selected_05_14.csv')
no04(fread('住院申報費用清單_icd_selected.csv')) %>% fwrite('住院申報費用清單_icd_selected_05_14.csv')

merge(unique(fread('住院申報費用清單_icd_selected_05_14.csv')[,5]),
	fread('子宮肌瘤-呂豪笙\\住診批價明細檔.csv')) %>% fwrite('子宮肌瘤住院明細.csv')
merge(unique(fread(　'門診處方歷史檔_icd_selected_05_14.csv')[,5]),
	fread('子宮肌瘤-呂豪笙\\門診批價明細檔.csv')) %>% fwrite('子宮肌瘤門診明細.csv')

# 拆分
x = unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5])
rbind(
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_1.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_2.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_3.csv'))) %>% fwrite('子宮肌瘤門診明細.csv')

view = function(x) fwrite(data.table(table(x[grep('^7[B-Z]-',收費編號)]))[order(-N)],'_.csv')
view(fread('子宮肌瘤住院明細.csv')[,7]) # 住院
view(fread('子宮肌瘤門診明細.csv')[,5]) # 門診
```
## 處方箋數、歸戶號數、門診住院號數
```
m = function(x) c('處方箋數', nrow(x), '歸戶號數', nrow(unique(x[,1])), '門診住院號數', nrow(unique(x[,2])))
m(fread('門.csv'))
m(fread('住.csv'))
```
## 頻率劑量
```
tmp = fread('子宮肌瘤門診明細.csv')
tmp[頻率 %in%  'QD']$頻率 = 1
tmp[頻率 %in% 'BID']$頻率 = 2
tmp[頻率 %in% 'TID']$頻率 = 3
tmp[頻率 %in% 'QID']$頻率 = 4
tmp[頻率 %in%  'HS']$頻率 = 1
tmp$頻率 %<>% as.numeric
tmp$劑量 %<>% as.numeric
f = function(x) data.table(c('收費名稱','每日劑量', '服藥週期'),c(
	tmp[收費編號 %in% x][1,35],
	mean(tmp[收費編號 %in% x]$劑量 * tmp[收費編號 %in% x]$頻率),
	mean(tmp[收費編號 %in% x]$天數)))
f('7C-E312     1GM') # 左歸丸
```
## 關聯分析
```
dcast(fread('子宮肌瘤住院明細.csv')[grep('^7[B-Z]-',收費編號)], 歸戶代號+住院號+批價日期~收費編號) %>% fwrite('住.csv')
dcast(fread('子宮肌瘤門診明細.csv')[grep('^7[B-Z]-',收費編號)], 歸戶代號+門診號+批價日期~收費編號) %>% fwrite('門.csv')

arm = function(x, s=.1, z=.3, b='support') sort(apriori(data.matrix(x), parameter=list(supp=s,conf=z)), by=b)
rul = function(x) x[!is.redundant(x)]
out = function(x) data.table(lhs = labels(lhs(x)), rhs = labels(rhs(x)), x@quality)
fread('門.csv')[,c(-3,-2,-1)] %>% arm(s=.01) %>% rul %T>% inspect %>% out %>% fwrite('門_arm.csv')
fread('住.csv')[,c(-3,-2,-1)] %>% arm        %>% rul %T>% inspect %>% out %>% fwrite('住_arm.csv')
```
## 網絡分析
```
sna = function(x,w=T,m='undirected'){x[x>=1]=1;simplify(graph.adjacency(t(x%<>%data.matrix)%*%x,weighted=w,mode=m))}
cop = function(g,m=cluster_optimal(g),v=degree(g),e=E(g)$weight,l=layout.circle) plot(m,g,vertex.size=v,edge.width=e,layout=l)
g = sna(fread('門.csv')[,c(-2,-1)][,c(143,152,555,396,552,550,650,129,54,58,353,127,116)])
cop(g, e=E(g)$weight^.1,v=degree(g)*3.5)
g = sna(fread('住.csv')[,c(-2,-1)][,c(25,5,45,82,102,104,112,185,135)])
cop(g, e=E(g)$weight^.1,v=degree(g)*4)
```
