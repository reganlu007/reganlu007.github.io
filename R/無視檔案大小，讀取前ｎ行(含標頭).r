name  = function(a)        strsplit(readLines(file(a, "r"), 1), split=',')[[1]]
read  = function(a, n = 5) read.table(text=readLines(file(a, "r"), n), sep=',', col.names=name(a))
