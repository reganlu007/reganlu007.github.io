library(data.table);library(magrittr)

tmp1 = fread('子宮肌瘤-呂豪笙\\住診批價明細檔.csv')
tmp2 = fread('子宮肌瘤-呂豪笙\\住診批價基本檔.csv')
tmp3 = fread('子宮肌瘤-呂豪笙\\住診醫囑檔.csv')[,c(-32,-19)]
tmp4 = fread('子宮肌瘤-呂豪笙\\住診藥囑檔.csv')[,c(-48,-44,-39,-28)]

fw = function(x, y) fwrite(merge(unique(fread('子宮肌瘤住院病患_05_14.csv')[,1])[c(850,892)], x), y)
fw(tmp1,'_1.csv')
fw(tmp2,'_2.csv')
fw(tmp3,'_3.csv')
fw(tmp4,'_4.csv')

tmp5 = fread('子宮肌瘤-呂豪笙\\門診批價明細檔.csv')
tmp6 = fread('子宮肌瘤-呂豪笙\\門診批價基本檔.csv')
tmp7 = fread('子宮肌瘤-呂豪笙\\門診醫囑檔.csv')[,c(-32,-19)]        
tmp8 = fread('子宮肌瘤-呂豪笙\\門診藥囑檔.csv')[,c(-48,-44,-39,-28)]
