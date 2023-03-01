//	破解    msg_16p name_16p
	dec_16p = (dic,arr,mod) => {
	mod = ['name_16p', 'msg_16p'].indexOf(mod);
	tmp = {};
	tmp[0]= arr;
	tmp[1]= tmp[0].map(x => x.toString(2).padStart(8,0)).join('');
	tmp[2]= {};
	tmp[4]=(mod + 14) * 16;
	tmp[5]= tmp[1].length / tmp[4];
for(var n = 0 ; n  < tmp[5]; n++){
	tmp[6]   = tmp[4] * n + 16 * mod;
	tmp[2][n]= {};
	tmp[2][n].index = !!mod ? tmp[1].slice(tmp[4] * n, tmp[6]): ''  ;
	tmp[2][n].value =         tmp[1].slice(tmp[6]    , tmp[6] + 224);
}	tmp	=	tmp[2];
	return	tmp;
};	get_name_16p = dec_16p(name_16p_dic,name_16p,'name_16p');
	get__msg_16p = dec_16p( msg_16p_dic, msg_16p, 'msg_16p');
//	man  kaodata 破解
	__code_kaodata=(arr,row,col)=>{tmp={};tmp[0]=arr;tmp[1]=tmp[0].map(x => Number(x).toString(2).padStart(row,0)).join('');tmp[2]=[];[...Array(tmp[1].length/24).keys()].map(x => tmp[2].push(tmp[1].slice(24*x,24*x+24)));tmp[3]=[];
	tmp[2].map(x=>{[...Array(row).keys()].map(y =>{tmp[4]='';[...Array(col).keys()].map(z => tmp[4]+= x[y+row*z]);tmp[4]=parseInt(tmp[4],2);tmp[3].push(tmp[4]);});});tmp=tmp[3];
	return	tmp;
};	decode_kaodata=(x)=>__code_kaodata(x,8,3);
	encode_kaodata=(x)=>__code_kaodata(x,3,8);
	get__kaodata = decode_kaodata(kaodata_dat);
	dec__hexdata = (arr) => {
	tmp = {};
	[...Array(41).keys()].map(x => {
		tmp[x]={};
		tmp[x].地形 = arr.slice(   0 + 156 * x,    0 + 156 * x + 156);
		tmp[x].出陣 = arr.slice(6396 + 156 * x, 6396 + 156 * x + 156);
	});
	return	tmp;
};	get__hexdata = dec__hexdata(hexdata_dat);

