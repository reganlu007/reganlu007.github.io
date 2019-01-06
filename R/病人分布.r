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

tmp1[,3]%>%unique
tmp1[資料年月<200500][,3]%>%unique

tmp2[,3]%>%unique
tmp2[資料年月<200500][,3]%>%unique

# 之後使用 excel 處理確診ID

merge(fread('門診處方歷史檔_確診ID.csv'),fread('門診處方歷史檔_icd_selected.csv'))     %>% fwrite('門診處方歷史檔_icd_selected_05_14')
merge(fread('住院申報費用清單_確診ID.csv'),fread('住院申報費用清單_icd_selected.csv')) %>% fwrite('住院申報費用清單_icd_selected_05_14')

tmp1 =	merge(unique(fread('住院申報費用清單_icd_selected_05_14.csv')[,5]),fread('子宮肌瘤-呂豪笙\\住診批價明細檔.csv'))
tmp2 =	rbind(
	merge(unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5]), fread('子宮肌瘤-呂豪笙\\門診批價明細檔_1.csv')),
	merge(unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5]), fread('子宮肌瘤-呂豪笙\\門診批價明細檔_2.csv')),
	merge(unique(fread('門診處方歷史檔_icd_selected_05_14.csv')[,5]), fread('子宮肌瘤-呂豪笙\\門診批價明細檔_3.csv')))
view = function(x)data.table(table(x[grep('^7[B-Z]-',收費編號)]))[order(-N)]
view(tmp1[,7])
view(tmp2[,5])

library(dplyr);library(arulesViz);library(igraph)
