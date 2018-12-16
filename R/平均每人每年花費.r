library(data.table);library(magrittr);library(dplyr)

門診 = function(x) fread(x) %>% group_by(歸戶代號) %>% summarise(sum(as.numeric(本院收費金額)), sum(as.numeric(病患自付金額)), sum(as.numeric(健保給付金額)), min(as.numeric(批價日期)), max(as.numeric(批價日期))) %>% data.table
住診 = function(x) fread(x) %>% group_by(歸戶代號) %>% summarise(sum(as.numeric(自付金額)), sum(as.numeric(健保金額)), min(as.numeric(批價日期)), max(as.numeric(批價日期)))

tmp門診中藥 = 門診('子宮肌瘤門診中藥.csv')
tmp門診中藥 %>% fwrite('門中金額.csv')

tmp門診西藥 = 門診('子宮肌瘤門診西藥.csv')
tmp門診西藥 %>% fwrite('門西金額.csv')

tmp住診中藥 = 住診('子宮肌瘤住診中藥.csv')
tmp住診中藥 %>% fwrite('住中金額.csv')

tmp住診西藥 = 住診('子宮肌瘤住診西藥.csv')
tmp住診西藥 %>% fwrite('住西金額.csv')
