library(data.table);library(magrittr);library(dplyr)

# 住院天數統計 
### 先用 excel 讀取 住院基本檔 後 轉換日期為 date 格式 重整住院天數 再用 R 篩選出整理好的歸戶 ID
sum((tmp = merge(住診, 住診批價基本))$住院天數)/length(unique(tmp$歸戶代號))

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
