# 無視資料大小，讀取前 n 行 (含標頭)
```
read.Lines   = function(x,  n ){
	pt   = file    (x, "r")
	name = strsplit(readLines(pt, 1), split=',')[[1]]
	data = read.table(text=readLines(pt, n), sep=',', col.names=name)
	data
}
```
