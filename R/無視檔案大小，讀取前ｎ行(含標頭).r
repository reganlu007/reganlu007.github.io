read  = function(a, n = 5){
    x = file(a, "r"); y = strsplit(readLines(x, 1), split=',')[[1]]
    read.table(text =readLines(x, n), sep=',', col.names = y )
}
