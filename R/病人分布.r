library(data.table);library(magrittr);library(dplyr)

# 準備檔案

歸戶 = fread('子宮肌瘤-呂豪笙\\歸戶個案.csv')
門診 = fread('子宮肌瘤-呂豪笙\\門診批價基本檔.csv') 
住診 = fread('子宮肌瘤-呂豪笙\\住診批價基本檔.csv')
急診 = fread('子宮肌瘤-呂豪笙\\急診醫囑基本資料檔-min.csv')

x = 門診
x = 住診
x = 急診

(x %>% group_by(歸戶代號, 院區) %>% summarise(min(資料年月))) %>% fwrite('_.csv')
(x %>% group_by(歸戶代號) %>% summarise(min(資料年月), max(資料年月))) %>% fwrite('_.csv')
(x %>% group_by(歸戶代號) %>% summarise(min(生日年))) %>% fwrite('_.csv')
fwrite(data.table(table(x$歸戶代號))[N>0][order(.)], '_.csv')

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
rbind(	門診歷史[grep(icd_9,疾病代號一),
	門診歷史[grep(icd_9,疾病代號二),
	門診歷史[grep(icd_9,疾病代號三),
	門診歷史[grep(icd_9,疾病代號四),
	門診歷史[grep(icd_9,疾病代號五),
	門診歷史[grep(icd_9,疾病代號六)]) %>% unique %>% fwrite('門診處方歷史檔_icd_selected.csv')

# 檢驗 確診為子宮肌瘤之歸戶代號 是否 <= 全歸戶代號，若 true 則輸出
fwrite(merge(
	data.table(unique(子宮肌瘤門診病患_05_14$歸戶代號)),
	data.table(unique(子宮肌瘤住院病患_05_14$歸戶代號)), all = T), '確診為子宮肌瘤之歸戶代號.csv')

(子宮肌瘤住院病患_05_14$主疾病代號%>%table%>%data.table)[order(-N)]%>%View
