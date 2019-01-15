#  子宮肌瘤
## 匯入函數
```
sapply(c('data.table','magrittr','visNetwork','dplyr','arulesViz','igraph'),function(x) do.call('require',list(x)))
SORT = function(x) data.table(table(x))[order(-N)]
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

no_04 =	function(x){
	y = unique(x[資料年月<200500][,3][[1]])
	z = unique(x[,3][[1]])
	w = data.table(z[!z %in% y])
	names(w)='歸戶代號'
	merge(w,x)
}
no_04(fread(　'門診處方歷史檔_icd_selected.csv')) %>% fwrite(　'門診處方歷史檔_icd_selected_05_14.csv')
no_04(fread('住院申報費用清單_icd_selected.csv')) %>% fwrite('住院申報費用清單_icd_selected_05_14.csv')

m = function(x) merge(unique(fread(x)[,5]),fread(y))
m('住院申報費用清單_icd_selected_05_14.csv','子宮肌瘤-呂豪笙\\住診批價明細檔.csv') %>% fwrite('子宮肌瘤住院明細.csv')
m(　'門診處方歷史檔_icd_selected_05_14.csv','子宮肌瘤-呂豪笙\\門診批價明細檔.csv') %>% fwrite('子宮肌瘤門診明細.csv')

# 拆分
x = unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5])
rbind(
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_1.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_2.csv')),
	merge(x, fread('子宮肌瘤-呂豪笙\\門診批價明細檔_3.csv'))) %>% fwrite('子宮肌瘤門診明細.csv')
fread('子宮肌瘤住院明細.csv')[,7][grep('^7[B-Z]-',收費編號)] %>% SORT %>% View # 住院
fread('子宮肌瘤門診明細.csv')[,5][grep('^7[B-Z]-',收費編號)] %>% SORT %>% View # 門診
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
to_1 = function(x){z=x[,-(1:3)];z[z>0]=1;data.table(x[,1:3],z)}
dcast(fread('子宮肌瘤門診明細.csv')[grep('^7[B-Z]-',收費編號)],歸戶代號+門診號+批價日期~收費編號) %>% to_1 %>% fwrite('門.csv')
dcast(fread('子宮肌瘤住院明細.csv')[grep('^7[B-Z]-',收費編號)],歸戶代號+住院號+批價日期~收費編號) %>% to_1 %>% fwrite('住.csv')

arm = function(x, s=.1, z=.3, b='support') sort(apriori(data.matrix(x), parameter=list(supp=s,conf=z)), by=b)
rul = function(x) x[!is.redundant(x)]
out = function(x) data.table(lhs = labels(lhs(x)), rhs = labels(rhs(x)), x@quality)
fread('門.csv')[,-(1:3)] %>% arm(s=.01) %>% rul %T>% inspect %>% out %T>% View %>% fwrite('門_arm.csv')
fread('住.csv')[,-(1:3)] %>% arm        %>% rul %T>% inspect %>% out %T>% View %>% fwrite('住_arm.csv')
```
## 網絡分析
```
sna = function(x, w=T, m='undirected') graph.adjacency(t(x%<>%data.matrix)%*%x,weighted=w,mode=m)%>% simplify
g = fread('門.csv')[,-(1:3)][,c(116,127,353,58,129,650,552,396,555,152,130,54,397,143,59,97,207,401,30,53,322,323,550,48,395)] %>%
	sna %>% toVisNetworkData
x = data.table(g$edges)[order(-weight)][1:40]
VIS_1 = visNetwork(width='100vw', height='100vh',
	nodes = data.frame(
		id    = g$nodes$id,
		label = g$nodes$label,
		value = c(7,5,5,2,4,2,2,4,1,1,2,3,3,2,3,2,2,2,2,2,2,9,2,3,4)),
		color.background = 'green'
	edges = data.frame(
		from  = x$from,
		to    = x$to,
		width = x$weight/1000))
VIS_1 %>% visLayout(randomSeed = 12)

g2 = fread('住.csv')[,-(1:3)][,c(135,185,112,104,102,82,45,5,25,132,156,133,147)] %>%
	sna %>% toVisNetworkData
x = data.table(g2$edges)[order(-weight)][1:40]
VIS_2 = visNetwork(width='100vw', height='100vh',
	nodes = data.frame(id = g2$nodes$id, label = g2$nodes$label, value = c(1.6,1.6,1,1,1,1,1,1,1,1.3,1.35,1,1), color.background = 'green'),
	edges = data.frame(from = x$from, to = x$to, width = x$weight/5))
VIS_2 %>% visLayout(randomSeed = 12)
```
## 經濟分析
```
x = fread(　'門診處方歷史檔_icd_selected_05_14.csv')
x = fread('住院申報費用清單_icd_selected_05_14.csv')
unique(x[,1]) # 歸戶代號
unique(x[,5]) # 門住代號

m = function(x,y) merge(unique(fread(x)[,1]),fread(y))
m('門.csv',　'門診處方歷史檔_icd_selected_05_14.csv') %>% fwrite('門診中.csv')
m('住.csv','住院申報費用清單_icd_selected_05_14.csv') %>% fwrite('住院中.csv')

n = function(x,y,z) merge(unique(merge(unique(fread(x)[,1]),fread(y))[grep('^P[1-9A-Z][A-Z][1-9]{3}[A-Z]',收費編號)][,1]),fread(z))
n('門.csv','子宮肌瘤門診明細.csv',　'門診處方歷史檔_icd_selected_05_14.csv') %>% fwrite('門診中西合用.csv')
n('住.csv','子宮肌瘤住院明細.csv','住院申報費用清單_icd_selected_05_14.csv') %>% fwrite('住院中西合用.csv')
```
