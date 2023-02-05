//	txt 16p 破解    msg_16p name_16p
//	mod = 0 or false : read name.16p
//	mod = 1 or  true : read  msg.16p
	dec_16p =  (dic,arr,mod) => {
	mod = ['name_16p', 'msg_16p'].indexOf(mod);
	tmp = {};
	tmp[0]= arr;
	tmp[1]= tmp[0].map(x => x.toString(2).padStart(8,0)).join('').replace(/,/g, '').split('');
	tmp.r =	[...Array(14+mod).keys()];
	tmp.c =	[...Array( 0+16 ).keys()];
	tmp.n =	[...Array( tmp[1].length / tmp.r.length / tmp.c.length).keys()];
	tmp[2]			= {}; tmp.n.map(n => {
	tmp[2][n]		= {}; tmp.r.map(r => {
	tmp[2][n][r]	= {}; tmp.c.map(c => {
	tmp[2][n][r][c]	=	  tmp[1][c+r * tmp.c.length + n * tmp.c.length * tmp.r.length];
	tmp[2][n][r][c]	=	!!mod && r == 0 && c < 16 ? tmp[2][n][r][c] * true : tmp[2][n][r][c] == 0 ? '' : '圖';
	}); /* c */
	tmp[2][n]['val']= [dic[n] || '', ''];tmp.c.map(c => {
	tmp[2][n]['val'][1] +=	!!mod ? tmp[2][n][0][c] : '';
	}); /* c */
	});	/* r */
	});	/* n */
	tmp =	tmp[2];	//	去蕪存菁
	return	tmp;
};	get_name_16p = () => dec_16p(name_16p_dic,name_16p,'name_16p');
	get__msg_16p = () => dec_16p( msg_16p_dic, msg_16p, 'msg_16p');
	see__msg_16p =(i) => console.table(get__msg_16p()[i]);
	see_name_16p =(i) => console.table(get_name_16p()[i]);
//	man kaodata 破解
	dec_kaodata	= (arr) => {
	tmp = {};
	tmp[0]= arr;
	tmp[1]=	tmp[0].map(x => x.toString(2).padStart(8,0)).join('');
	tmp[2]= [];
	tmp.r = 24;
	[...Array(tmp[1].length / tmp.r).keys()].map(x => tmp[2].push(tmp[1].slice(tmp.r * x, tmp.r * x + tmp.r)));
	tmp[3]= [];   tmp[2].map(x => {
	[...Array(8).keys()].map(y => {
	tmp[4]= ''; [...Array(3).keys()].map(z => tmp[4]+= x[y + 8 * z]);
	tmp[4]= parseInt(tmp[4], 2);
	tmp[3].push(['000','0a0','f50','ff0','05f','0af','f5a','fff'][tmp[4]]);
	}); /* c */
	}); /* r */
	tmp =	tmp[3];	//	去蕪存菁
	return	tmp;
};	get_kaodata	= () => dec_kaodata(kaodata_dat);
	see_kaodata	=(i) => { log  = ''; k = get_kaodata().map(x => 'background:#' + x);
	[...Array(64).keys()].map(x => log += '%c　');
	[...Array(40).keys()].map(x => { x = 64 * x + i * 64 * 40;
		eval(`console.log(log
	,	k[ 0 + x],	k[ 1 + x],	k[ 2 + x],	k[ 3 + x],	k[ 4 + x],	k[ 5 + x],	k[ 6 + x],	k[ 7 + x]
	,	k[ 8 + x],	k[ 9 + x],	k[10 + x],	k[11 + x],	k[12 + x],	k[13 + x],	k[14 + x],	k[15 + x]
	,	k[16 + x],	k[17 + x],	k[18 + x],	k[19 + x],	k[20 + x],	k[21 + x],	k[22 + x],	k[23 + x]
	,	k[24 + x],	k[25 + x],	k[26 + x],	k[27 + x],	k[28 + x],	k[29 + x],	k[30 + x],	k[31 + x]
	,	k[32 + x],	k[33 + x],	k[34 + x],	k[35 + x],	k[36 + x],	k[37 + x],	k[38 + x],	k[39 + x]
	,	k[40 + x],	k[41 + x],	k[42 + x],	k[43 + x],	k[44 + x],	k[45 + x],	k[46 + x],	k[47 + x]
	,	k[48 + x],	k[49 + x],	k[50 + x],	k[51 + x],	k[52 + x],	k[53 + x],	k[54 + x],	k[55 + x]
	,	k[56 + x],	k[57 + x],	k[58 + x],	k[59 + x],	k[60 + x],	k[61 + x],	k[62 + x],	k[63 + x]
	);`);
	});
};	man_kaodata =(i) => { if(!isNaN(i)) {i--; i %= 219; i += 219; i %= 219; see_kaodata(i);} }