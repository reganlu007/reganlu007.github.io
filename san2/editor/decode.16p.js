//	decode_16p 破解函式
	decode_16p = (arr, dic) => {tmp = {0: arr};
tmp[1]=     tmp[0].map(x => x.toString(2).padStart(8,0)) + '';
tmp[2]=     tmp[1].replace(/,/g, '').split('');
tmp.c = 16; tmp.c = [...Array(tmp.c).keys()];
tmp.r = 14; tmp.r = [...Array(tmp.r).keys()];
tmp.n = tmp[2].length / tmp.r.length / tmp.c.length ;
tmp.n = [...Array(tmp.n).keys()];
tmp[3]          = {}; tmp.n.map(n => {
tmp[3][n]       = {}; tmp.r.map(r => {
tmp[3][n].text  = [dic[n] || null];
tmp[3][n][r]    = {}; tmp.c.map(c => {
tmp[3][n][r][c] = tmp[2][c + r * 16 + n * 16 * 14];
tmp[3][n][r][c] = tmp[3][n][r][c] == 0 ? '' : '圖';
});
});
});
tmp =  tmp[3];	//	去蕪存菁
return tmp;
}
//	使用範例
//	載入檔案
//	var name_16p_words = decode_16p(name_16p);

//	console.table(name_16p_words[0]); //	一
//	console.table(name_16p_words[1]); //	乙
//	console.table(name_16p_words[2]); //	丁

