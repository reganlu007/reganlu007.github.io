library(data.table);library(magrittr);library(dplyr)

tmp1 = fread('子宮肌瘤-呂豪笙\\住診批價明細檔.csv')
tmp2 = fread('子宮肌瘤-呂豪笙\\住診批價基本檔.csv')
tmp3 = fread('子宮肌瘤-呂豪笙\\住診醫囑檔.csv')[,c(-32,-19)]
tmp4 = fread('子宮肌瘤-呂豪笙\\住診藥囑檔.csv')[,c(-48,-44,-39,-28)]

fw = function(x = '', y, z) fwrite(merge(unique(fread('子宮肌瘤住院病患_05_14.csv')[,1])[x], y), z)
fw(c(850, 892), tmp1,'_1.csv')
fw(c(850, 892), tmp2,'_2.csv')
fw(c(850, 892), tmp3,'_3.csv')
fw(c(850, 892), tmp4,'_4.csv')

a1 = fread('子宮肌瘤-呂豪笙\\門診批價明細檔_1.csv')[,-4]
a2 = fread('子宮肌瘤-呂豪笙\\門診批價明細檔_2.csv')[,-4]
a3 = fread('子宮肌瘤-呂豪笙\\門診批價明細檔_3.csv')[,-4]

tmp1 = dcast(merge(unique(fread('門診診斷檔_不孕.csv')[,3]),fread('子宮肌瘤門診中藥_醫師.csv')), 門診號+主治醫師代號+批價日期~收費編號)
tmp2 = dcast(merge(unique(fread('住院申報費用清單_不孕.csv')[,3]),fread('子宮肌瘤住診中藥_醫師.csv')), 住院號+醫師別+批價日期~收費編號)

tmp6 = fread('子宮肌瘤-呂豪笙\\門診批價基本檔.csv')
tmp7 = fread('子宮肌瘤-呂豪笙\\門診醫囑檔.csv')[,c(-32,-19)]        
tmp8 = fread('子宮肌瘤-呂豪笙\\門診藥囑檔.csv')[,c(-48,-44,-39,-28)]
