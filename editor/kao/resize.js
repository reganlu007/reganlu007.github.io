//  範例字串
str = '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890';
//  延展成為正常頭像 (abc => aabbcc)
resize_by_regan_0 = x => x.replace(  /.{48}/g,'$&,').split(',').map(x=>x+','+x).toString().replace(/,/g,'\n');
//  大神指點簡化語法
resize_by_yuxio_1 = x => x.  match(  /.{48}/g).map(l => `${l}\n${l}`).join('\n');
//  大神指點簡化語法
resize_by_yuxio_2 = x => x.  match(/.{1,48}/g).map(l => `${l}\n${l}`).join('\n');
//  測試方法
console.log('resize_by_regan_0 :\n\n' + resize_by_regan_0(str));
console.log('resize_by_yuxio_1 :\n\n' + resize_by_yuxio_1(str));
console.log('resize_by_yuxio_2 :\n\n' + resize_by_yuxio_2(str));

