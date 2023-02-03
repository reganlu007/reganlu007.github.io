//	decode_16p 破解函式
//	mod = 0 or false : read name.16p
//	mod = 1 or  true : read  msg.16p
	decode_16p =  (arr,dic,mod) => {tmp = {0: arr, 'r': mod };
tmp[1]=     tmp[0].map(x => x.toString(2).padStart(8,0)) + '';
tmp[2]=     tmp[1].replace(/,/g, '').split('');
tmp.r+= 14; tmp.r = [...Array(tmp.r).keys()];
tmp.c = 16; tmp.c = [...Array(tmp.c).keys()];
tmp.n = tmp[2].length / tmp.r.length / tmp.c.length ;
tmp.n = [...Array(tmp.n).keys()];
tmp[3]          = {}; tmp.n.map(n => {
tmp[3][n]       = {}; tmp.r.map(r => {
tmp[3][n].value = [dic[n] || null];
tmp[3][n][r]    = {}; tmp.c.map(c => {
tmp[3][n][r][c] = tmp[2][c + r * tmp.c.length + n * tmp.c.length * tmp.r.length];
if(!!mod && r ===0 && c < tmp.c.length){
tmp[3][n][r][0]+= tmp[3][n][r][c];
tmp[3][n][r][c] = '';
tmp[3][n].index = [parseInt(tmp[3][n][0][0] , 2 )];
}else{
tmp[3][n][r][c] = tmp[3][n][r][c] == 0 ? '' : '圖';
}
});	// c
});	// r
});	// n
tmp =  tmp[3];	//	去蕪存菁
return tmp;
};	get_name_16p = () => decode_16p(name_16p, name_16p_dic, 0); see_name_16p =(i) => console.table(get_name_16p()[i]);
	get__msg_16p = () => decode_16p( msg_16p,  msg_16p_dic, 1); see__msg_16p =(i) => console.table(get__msg_16p()[i]);
