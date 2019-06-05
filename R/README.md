#  子宮肌瘤
## 匯入函數
匯入以下套件
```
pkg = c('data.table','magrittr','visNetwork','dplyr','arulesViz','igraph','bit64')
sapply(pkg, function(x) do.call('install.packages',list(x)))
sapply(pkg, function(x) do.call('require',list(x)))
SORT = function(x) data.table(table(x))[order(-N)]
to_1 = function(x){z=x[,-(1:3)];z[z>0]=1;data.table(x[,1:3],z)}
arm = function(x, s=.1, z=.3, b='support') sort(apriori(data.matrix(x), parameter=list(supp=s,conf=z)), by=b)
rul = function(x) x[!is.redundant(x)]
out = function(x) data.table(lhs = labels(lhs(x)), rhs = labels(rhs(x)), x@quality)
sna = function(x, w=T, m='undirected') simplify(graph.adjacency(t(x%<>%data.matrix)%*%x,weighted=w,mode=m))
setwd(choose.dir())
```
## 基本資料
```
icd_9 = '^218|^617|^6253|^6254|^626|^628'
住院申報 = fread('住院申報費用檔.csv')
rbind(	住院申報[grep(icd_9,主疾病代號)],
	住院申報[grep(icd_9,疾病代號一)],
	住院申報[grep(icd_9,疾病代號二)],
	住院申報[grep(icd_9,疾病代號三)],
	住院申報[grep(icd_9,疾病代號四)]) %>% unique %>% fwrite('住院申報費用清單_icd_selected.csv')
門診歷史 = fread('門診處方歷史檔.csv')
rbind(	門診歷史[grep(icd_9,疾病代號一)],
	門診歷史[grep(icd_9,疾病代號二)],
	門診歷史[grep(icd_9,疾病代號三)],
	門診歷史[grep(icd_9,疾病代號四)],
	門診歷史[grep(icd_9,疾病代號五)],
	門診歷史[grep(icd_9,疾病代號六)]) %>% unique %>% fwrite('門診處方歷史檔_icd_selected.csv')
rm(住院申報,門診歷史);gc()

no_04 =	function(x){
	w = data.table(unique(x$歸戶代號)[!unique(x$歸戶代號) %in% unique(x[資料年月<200500]$歸戶代號)])
	names(w)='歸戶代號'
	merge(w,x)
}
no_04(fread(　'門診處方歷史檔_icd_selected.csv')) %>% fwrite(　'門診處方歷史檔_icd_selected_05_14.csv')
no_04(fread('住院申報費用清單_icd_selected.csv')) %>% fwrite('住院申報費用清單_icd_selected_05_14.csv')

fwrite(merge(unique(fread('住院申報費用清單_icd_selected_05_14.csv')[,5]),fread('住院批價明細檔.csv')),'子宮肌瘤住院明細.csv')
fwrite(merge(unique(fread(  '門診處方歷史檔_icd_selected_05_14.csv')[,5]),fread('門診批價明細檔.csv')),'子宮肌瘤門診明細.csv')

# 拆分
x = unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5])
rbind(
	merge(x, fread('門診批價明細檔_1.csv')),
	merge(x, fread('門診批價明細檔_2.csv')),
	merge(x, fread('門診批價明細檔_3.csv'))) %>% fwrite('子宮肌瘤門診明細.csv')
fread('子宮肌瘤門診明細.csv')[,5][grep('^7[B-Z]-',收費編號)] %>% SORT %>% View
fread('子宮肌瘤住院明細.csv')[,7][grep('^7[B-Z]-',收費編號)] %>% SORT %>% View
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
dcast(fread('子宮肌瘤門診明細.csv')[grep('^7[B-Z]-',收費編號)],歸戶代號+門診號+批價日期~收費編號) %>% to_1 %>% fwrite('門.csv')
dcast(fread('子宮肌瘤住院明細.csv')[grep('^7[B-Z]-',收費編號)],歸戶代號+住院號+批價日期~收費編號) %>% to_1 %>% fwrite('住.csv')

fread('門.csv')[,-(1:3)] %>% arm(s=.01) %>% rul %T>% inspect %>% out %T>% View %>% fwrite('門_arm.csv')
fread('住.csv')[,-(1:3)] %>% arm        %>% rul %T>% inspect %>% out %T>% View %>% fwrite('住_arm.csv')
```
## 處方箋數、歸戶號數、門診住院號數
```
m = function(x) data.table(
	c('中藥種類','處方箋數','歸戶號數','門住號數','總中藥量/處方'),
	c(ncol(x)-3, nrow(x), nrow(unique(x[,1])), nrow(unique(x[,2])), sum(m)/nrow(m)))
m(to_1(fread('門.csv')))
m(to_1(fread('住.csv')))
```
## 網絡分析
```
g = fread('門.csv')[,-(1:3)][,c(116,127,353,58,129,650,552,396,555,152,130,54,397,143,59,97,207,401,30,53,322,323,550,48,395)]
g = fread('住.csv')[,-(1:3)][,c(135,185,112,104,102,82,45,5,25,132,156,133,147)]
x = data.table(toVisNetworkData(sna(g))$edges)[order(-weight)][1:40]
VIS = visNetwork(width='100vw', height='100vh',
	nodes = data.frame(
		id    = g$nodes$id,
		label = g$nodes$label,
		value = c(7,5,5,2,4,2,2,4,1,1,2,3,3,2,3,2,2,2,2,2,2,9,2,3,4)),
	#	value = c(1.6,1.6,1,1,1,1,1,1,1,1.3,1.35,1,1),
		color.background = 'green'),
	edges = data.frame(
		from  = x$from,
		to    = x$to,
		width = x$weight*2/max(x$weight))) %>% visLayout(randomSeed = 12);VIS
```
## 中藥前三名醫師
```
SORT(fread('門診中.csv')[,45]) # 前三名醫師編號
f0 = fread('子宮肌瘤門診明細.csv')[grep('^7[B-Z]-',收費編號)]
f1 = function(x) dcast(f0[門診號 %in% (y=fread('門診中.csv'))[醫師代號 %in% SORT(y[,45])[x,1][[1]]]$門診號],歸戶代號+門診號+批價日期~收費編號)
f1(1) %>% to_1 %>% fwrite('門1.csv')
f1(2) %>% to_1 %>% fwrite('門2.csv')
f1(3) %>% to_1 %>% fwrite('門3.csv')

fread('門1.csv')[,-(1:3)] %>% arm(s=.01) %>% rul %T>% inspect %>% out %T>% View %>% fwrite('門1_arm.csv')
fread('門2.csv')[,-(1:3)] %>% arm(s=.01) %>% rul %T>% inspect %>% out %T>% View %>% fwrite('門2_arm.csv')
fread('門3.csv')[,-(1:3)] %>% arm(s=.01) %>% rul %T>% inspect %>% out %T>% View %>% fwrite('門3_arm.csv')
```
節點大小：見 nodes 中的 value，值 = (單一統計量 / 平均單一統計量) * 自訂大小參數

連結粗細：見 edges 中的 width，值 = (weight 屬性 / weight 最大值) * 自訂大小參數
```
x1 = data.table((g1 = fread('門1.csv')[,-(1:3)][,c(281,26,124,315,314,107,81,108,211,105,119,493,426,340,212,132,429,94,254,424)] %>% sna %>% toVisNetworkData)$edges)[order(-weight)][1:40]
VIS_1 = visNetwork(width='100vw', height='100vh',
	nodes = data.frame(
		id    = g1$nodes$id,
		label = g1$nodes$label,
		value = c(5,4,4,2,3,3,2,2,2,2,1,1,1,1,2,1,1,7,6,1),
		color.background = 'green'),
	edges = data.frame(
		from  = x1$from,
		to    = x1$to,
		width = x1$weight*5/max(x1$weight))) %>% visLayout(randomSeed = 1);VIS_1
		
x2 = data.table((g2 = fread('門2.csv')[,-(1:3)][,c(94,97,247,96,44,43,199,251,152,114,93,108,200,246,212,196,201,84,48,225,117)] %>% sna %>% toVisNetworkData)$edges)[order(-weight)][1:40]
VIS_2 = visNetwork(width='100vw', height='100vh',
	nodes = data.frame(
		id    = g2$nodes$id,
		label = g2$nodes$label,
		value = c(2,2,2,3,2,1,2,1,1,1,2,1,2,2,2,2,1,4,2,3,2),
		color.background = 'green'),
	edges = data.frame(
		from  = x2$from,
		to    = x2$to,
		width = x2$weight*5/max(x2$weight))) %>% visLayout(randomSeed = 1);VIS_2
		
x3 = data.table((g3 = fread('門3.csv')[,-(1:3)][,c(306,247,167,248,43,78,101,38,263,103,274,48,162,47,119,207,32,122,290,31,34,90,52,115)] %>% sna %>% toVisNetworkData)$edges)[order(-weight)][1:40]
VIS_3 = visNetwork(width='100vw', height='100vh',
	nodes = data.frame(
		id    = g3$nodes$id,
		label = g3$nodes$label,
		value = c(6,5,5,5,3,3,3,3,3,2,3,2,2,2,2,2,2,1,1,1,1,12,2,1),
		color.background = 'green'),
	edges = data.frame(
		from  = x3$from,
		to    = x3$to,
		width = x3$weight*5/max(x3$weight))) %>% visLayout(randomSeed = 1);VIS_3
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
## 左歸丸
```
x = '7C-E312     1GM'
fwrite(fread(　'門診處方歷史檔_icd_selected_05_14.csv')[門診號 %in% unique(fread('子宮肌瘤門診明細.csv')[grep(x,收費編號)]$門診號)],
'門診左歸丸.csv')
fwrite(fread('住院申報費用清單_icd_selected_05_14.csv')[住院號 %in% unique(fread('子宮肌瘤住院明細.csv')[grep(x,收費編號)]$住院號)],
'住院左歸丸.csv')
```
## 鐵劑
```
x = 'PLB001M|PLB008M|PLB010M|PLB012M|P3B198M'
fwrite(fread(　'門診處方歷史檔_icd_selected_05_14.csv')[門診號 %in% unique(fread('子宮肌瘤門診明細.csv')[grep(x,收費編號)]$門診號)],
'門診鐵劑.csv')
fwrite(fread('住院申報費用清單_icd_selected_05_14.csv')[住院號 %in% unique(fread('子宮肌瘤住院明細.csv')[grep(x,收費編號)]$住院號)],
'住院鐵劑.csv')
```
