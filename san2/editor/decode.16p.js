//	破解    msg_16p name_16p
function	dec_16p(dic,arr,mod){
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
//	man kaodata 破解
	dec_kaodata	= (arr) => {
	tmp = {};
	tmp[0]= arr;
	tmp[0]= kaodata_dat;
	tmp[1]=	tmp[0].map(x => x.toString(2).padStart(8,0)).join('');
	tmp[2]= [];
	tmp.r = 24;
	[...Array(tmp[1].length / tmp.r).keys()].map(x => tmp[2].push(tmp[1].slice(tmp.r * x, tmp.r * x + tmp.r)));
	tmp[3]= [];   tmp[2].map(x => {
	[...Array(8).keys()].map(y => {
	tmp[4]= ''; [...Array(3).keys()].map(z => tmp[4]+= x[y + 8 * z]);
	tmp[4]= parseInt(tmp[4], 2);
	tmp[3].push(tmp[4]);
	}); /* c */
	}); /* r */
	tmp          = tmp[3].join('');	//	去蕪存菁
	return	tmp;
};	get__kaodata = dec_kaodata(kaodata_dat);