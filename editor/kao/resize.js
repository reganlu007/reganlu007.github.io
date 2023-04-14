//  延展成為正常頭像 (abc => aabbcc)
resize_by_regan = x => x.replace(/.{48}/g,'$&,').split(',').map(x=>x+','+x).toString().replace(/,/g,'\n');
//  大神指點簡化語法
resize_by_yuxio = x => x.  match(/.{48}/g).map(l => `${l}\n${l}`).join('\n');
