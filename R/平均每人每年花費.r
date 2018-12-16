library(data.table);library(magrittr);library(dplyr)
# 門診用

tmp門診中藥 = fread('子宮肌瘤門診中藥.csv') %>% group_by(歸戶代號) %>% summarise(
	sum(as.numeric(本院收費金額)), sum(as.numeric(病患自付金額)), sum(as.numeric(健保給付金額)), min(as.numeric(資料年月)), max(as.numeric(資料年月)))
tmp門診中藥
fwrite(tmp門診中藥,'門診中藥.csv')

tmp門診西藥 = fread('子宮肌瘤門診西藥.csv') %>% group_by(歸戶代號) %>% summarise(
	sum(as.numeric(本院收費金額)), sum(as.numeric(病患自付金額)), sum(as.numeric(健保給付金額)), min(as.numeric(資料年月)), max(as.numeric(資料年月)))
tmp門診西藥
fwrite(tmp門診西藥,'門診西藥.csv')

# 住診用

tmp住診中藥 = fread('子宮肌瘤住診中藥.csv') %>% group_by(歸戶代號) %>% summarise(sum(as.numeric(自付金額)), sum(as.numeric(健保金額)), min(as.numeric(資料年月)), max(as.numeric(資料年月)))
tmp住診中藥
fwrite(tmp住診中藥,'住診中藥.csv')

tmp住診西藥 = fread('子宮肌瘤住診西藥.csv') %>% group_by(歸戶代號) %>% summarise(sum(as.numeric(自付金額)), sum(as.numeric(健保金額)), min(as.numeric(資料年月)), max(as.numeric(資料年月)))
tmp住診西藥
fwrite(tmp住診西藥,'住診西藥.csv')
