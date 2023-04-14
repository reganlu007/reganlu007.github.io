//  延展成為正常頭像 (abc => aabbcc)
resize_from_1_to_2=(x)=>x.replace(/.{48}/g,'$&,').split(',').map(x=>x+','+x).toString().replace(/,/g,'\n');
