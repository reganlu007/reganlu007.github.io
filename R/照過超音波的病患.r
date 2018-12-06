library(data.table)
id = fread('確診為子宮肌瘤之歸戶代號.csv')
tmp1 = merge(id,fread('子宮肌瘤-呂豪笙\\門診批價明細檔.csv'))[grep('^S49-10', 收費編號)]
tmp1
fwrite(merge(id,fread('子宮肌瘤-呂豪笙\\住診批價明細檔.csv'))[grep('^S49-10', 收費編號)], '住院超音波.csv')
