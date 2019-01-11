#  子宮肌瘤
## 匯入函數
```
sapply(c('data.table','magrittr','visNetwork','dplyr','arulesViz','igraph','doBy'), function(x) do.call('require', list(x)))
```
有 FALSE 代表本機尚未安裝該套件，請用 install.packages 安裝
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

m = function(x) merge(unique(fread(x)[,5]),fread(y))
m('住院申報費用清單_icd_selected_05_14.csv','子宮肌瘤-呂豪笙\\住診批價明細檔.csv') %>% fwrite('子宮肌瘤住院明細.csv')
m(　'門診處方歷史檔_icd_selected_05_14.csv','子宮肌瘤-呂豪笙\\門診批價明細檔.csv') %>% fwrite('子宮肌瘤門診明細.csv')

# 拆分
x = unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5])
rbind(
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_1.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_2.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_3.csv'))) %>% fwrite('子宮肌瘤門診明細.csv')

SORT = function(x) data.table(table(x[grep('^7[B-Z]-',收費編號)]))[order(-N)]
fread('子宮肌瘤住院明細.csv')[,7] %>% SORT %>% View # 住院
fread('子宮肌瘤門診明細.csv')[,5] %>% SORT %>% View # 門診
```
## 處方箋數、歸戶號數、門診住院號數
```
m = function(x){x[,-(1:3)]->m;m[m>1]=1;data.table(
	c('中藥種類','處方箋數','歸戶號數','門住號數','總中藥量/處方'),
	c(ncol(x)-3, nrow(x), nrow(unique(x[,1])), nrow(unique(x[,2])), sum(m)/nrow(m)))}
m(fread('門.csv'));m(fread('住.csv'))
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
f = function(x) data.table(
	c('收費名稱','每日劑量','服藥週期'),c(
	 tmp[收費編號 %in% x][1,35],
	mean(tmp[收費編號 %in% x]$劑量 * tmp[收費編號 %in% x]$頻率),
	mean(tmp[收費編號 %in% x]$天數)))
f('7C-E312     1GM') # 左歸丸
```
## 關聯分析
```
dcast(fread('子宮肌瘤門診明細.csv')[grep('^7[B-Z]-',收費編號)],歸戶代號+門診號+批價日期~收費編號) %>% fwrite('門.csv')
dcast(fread('子宮肌瘤住院明細.csv')[grep('^7[B-Z]-',收費編號)],歸戶代號+住院號+批價日期~收費編號) %>% fwrite('住.csv')

arm = function(x, s=.1, z=.3, b='support', mi=1, ma=10) sort(apriori(data.matrix(x), parameter=list(supp=s,conf=z,minlen=mi,maxlen=ma)), by=b)
rul = function(x) x[!is.redundant(x)]
out = function(x) data.table(lhs = labels(lhs(x)), rhs = labels(rhs(x)), x@quality)
fread('門.csv')[,-(1:3)] %>% arm(ma=1,s=.01) %>% rul %T>% inspect %>% out %T>% View %>% fwrite('門_arm.csv')
fread('住.csv')[,-(1:3)] %>% arm(ma=1)       %>% rul %T>% inspect %>% out %T>% View %>% fwrite('住_arm.csv')
```
## 網絡分析
```
sna = function(x, w=T, m='undirected') {x[x>0]=1;simplify(graph.adjacency(t(x%<>%data.matrix)%*%x,weighted=w,mode=m))}
cop = function(g, m=cluster_optimal(g), v=degree(g), e=E(g)$weight, f=1, l=layout_nicely)
	plot(m,g,vertex.size=v,vertex.label.font=f,edge.width=e,layout=l)
g = sna(fread('門.csv')[,-(1:3)][,c(395,323,401,97,397,130,143,152,129,396,555,552,550,650,207,48,59,54,58,353,127,116)])
E(g)$weight
cop(g, e=ifelse(E(g)$weight<10000,0,E(g)$weight^.2),v=degree(g),f=2)
g = sna(fread('住.csv')[,-(1:3)][,c(147,133,156,132,25,5,45,82,102,104,112,185,135)])
cop(g, e=E(g)$weight/5,v=degree(g)^2.1,f=2,l=layout.circle)
```
## 經濟分析
```
x = fread(　'門診處方歷史檔_icd_selected_05_14.csv')
x = fread('住院申報費用清單_icd_selected_05_14.csv')
cnt = function(x) nrow(unique(x))
cnt(x[, 1]) # 歸戶代號
cnt(x[, 5]) # 門住代號

money = function(x,y) merge(unique(fread(x)[,1]),fread(y))
sum(money('門.csv',　'門診處方歷史檔_icd_selected_05_14.csv')[,37]/1) # 中藥門診>0 之醫療費用合計金額
sum(money('住.csv','住院申報費用清單_icd_selected_05_14.csv')[,53]/1) # 中藥住院>0 之醫療費用合計金額
```
# 視覺化
```
visNetwork(width = '100%', height = '768px', data.frame(id=1:30), data.frame(
from =c(2, 8, 11, 12, 13, 5, 7, 7, 13, 8, 14, 15, 15, 16, 15, 14, 17, 3, 18, 6, 19, 20, 21, 12, 22),
to   =c(1, 2, 2, 3, 2, 4, 4, 5, 1, 1, 2, 4, 5, 6, 7, 8, 2, 1, 8, 8, 9, 10, 9, 1, 2)))
```
