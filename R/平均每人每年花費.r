library(data.table);library(magrittr);library(dplyr)

# 門診用

門診 = fread('子宮肌瘤-呂豪笙\\門診批價明細檔.csv')
門診中藥 = 門診[grep('^7[B-Z]-'               , 收費編號)] # 中藥
門診西藥 = 門診[grep('^P[A-Z]{2}[0-9]{3}[A-Z]', 收費編號)] # 西藥

門診中藥%>%fwrite('門診中藥.csv')
門診西藥%>%fwrite('門診西藥.csv')

# 住診用

住診 = fread('子宮肌瘤-呂豪笙\\住診批價明細檔-min.csv')
住診中藥 = 門診[grep('^7[B-Z]-'               , 收費編號)] # 中藥
住診西藥 = 門診[grep('^P[A-Z]{2}[0-9]{3}[A-Z]', 收費編號)] # 西藥

# 門診用

tmp = merge(門診中藥,fread('子宮肌瘤-呂豪笙\\歸戶.csv'))
tmp

tmp中藥 = 門診中藥 %>% group_by(歸戶代號) %>% summarise(
	sum(as.numeric(本院收費金額)),
	sum(as.numeric(病患自付金額)),
	sum(as.numeric(健保給付金額)),
	min(as.numeric(資料年月)),
	max(as.numeric(資料年月)))
tmp中藥
fwrite(tmp中藥,'門診中藥.csv')

tmp西藥 = 門診西藥 %>% group_by(歸戶代號) %>% summarise(
	sum(as.numeric(本院收費金額)),
	sum(as.numeric(病患自付金額)),
	sum(as.numeric(健保給付金額)),
	min(as.numeric(資料年月)),
	max(as.numeric(資料年月)))
tmp西藥
fwrite(tmp西藥,'門診西藥.csv')

# 住診用

tmp住診中藥 =	住診中藥 %>% group_by(歸戶代號) %>% summarise(
	sum(as.numeric(自付金額)),
	sum(as.numeric(健保金額)),
	min(as.numeric(資料年月)),
	max(as.numeric(資料年月)))
tmp住診中藥
fwrite(tmp住診中藥,'住診中藥.csv')

tmp住診西藥 =	住診西藥 %>% group_by(歸戶代號) %>% summarise(
	sum(as.numeric(自付金額)),
	sum(as.numeric(健保金額)),
	min(as.numeric(資料年月)),
	max(as.numeric(資料年月)))
tmp住診西藥
fwrite(tmp住診西藥,'住診西藥.csv')
