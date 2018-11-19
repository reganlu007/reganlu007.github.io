readHead=function(x){
	pt  =file(x, "r")
	name=strsplit(readLines(pt, 1), split=',')[[1]]
	data=read.table(text=readLines(pt, 6), sep=',', col.names=name)
	data
}
