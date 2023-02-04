//	msg_16p name_16p 破解
//	mod = 0 or false : read name.16p
//	mod = 1 or  true : read  msg.16p
	dec_16p =  (dic,arr,mod) => {
	mod = ['name_16p', 'msg_16p'].indexOf(mod);
	tmp = { 'c': 16, 'r': mod + 14, 0: arr };
	tmp[1]=	tmp[0].map(x => x.toString(2).padStart(8,0)) + '';
	tmp[2]=	tmp[1].replace(/,/g, '').split('');
	tmp.r =	[...Array(tmp.r).keys()];
	tmp.c =	[...Array(tmp.c).keys()];
	tmp.n =	tmp[2].length / tmp.r.length / tmp.c.length ;
	tmp.n =	[...Array(tmp.n).keys()];
	tmp[3]			= {}; tmp.n.map(n => {
	tmp[3][n]		= {}; tmp.r.map(r => {
	tmp[3][n][r]	= {}; tmp.c.map(c => {
	tmp[3][n][r][c]	=     tmp[2][c + r * tmp.c.length + n * tmp.c.length * tmp.r.length];
	tmp[3][n][r][c]	=   !!mod && r == 0 && c < 16 ? tmp[3][n][r][c] * true : tmp[3][n][r][c] == 0 ? '' : '圖';
	}); /* c */
	tmp[3][n]['val']     = [dic[n] || '', ''];
	tmp.c.map(c => {
	tmp[3][n]['val'][1] += !!mod ? tmp[3][n][0][c] : '';
	}); /* c */
	});	/* r */
	});	/* n */
	tmp =	tmp[3];	//	去蕪存菁
	return	tmp;
};	get_name_16p = () => dec_16p(name_16p_dic,name_16p,'name_16p'); see_name_16p =(i) => console.table(get_name_16p()[i]);
	get__msg_16p = () => dec_16p( msg_16p_dic, msg_16p, 'msg_16p'); see__msg_16p =(i) => console.table(get__msg_16p()[i]);

	kao_palette = ['#000000', '#10B251', '#F35100', '#F3E300', '#0041F3', '#00C3F3', '#F351D3', '#F3F3F3'];
	dec_kaodata	= (arr) => {
	tmp = { 'c': 16, 'r': 14, 0: arr };
	tmp[1]=	tmp[0].map(x => x.toString(2).padStart(8,0)) + '';
	tmp[2]=	tmp[1].replace(/,/g, '').split('');
	return	tmp;
};	get_kaodata	= () => {
	return 'not yet.';
}