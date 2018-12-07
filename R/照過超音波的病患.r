library(data.table)
id  = fread('確診為子宮肌瘤之歸戶代號.csv')
tmp = fread('子宮肌瘤-呂豪笙\\門診批價明細檔.csv')[,-4]
fwrite(rbind(
       merge(id,tmp[       1: 35000000])[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)] ,
       merge(id,tmp[35000001: 70000000])[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)] ,
       merge(id,tmp[70000001:105767451])[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)]),'門診超音波.csv')
fwrite(merge(id,tmp[,-4])[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)],'門診超音波.csv')
fwrite(merge(id,fread('門診批價明細檔_1.csv'))[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)],'門院超音波_1.csv')
fwrite(merge(id,fread('門診批價明細檔_2.csv'))[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)],'門院超音波_2.csv')
fwrite(merge(id,fread('門診批價明細檔_3.csv'))[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)],'門院超音波_3.csv')

fwrite(merge(id,fread('子宮肌瘤-呂豪笙\\住診批價明細檔.csv'))[grep('^S49-101|^S49-104|^S49-104P|^S49-111', 收費編號)],'住院超音波.csv')
