readHead = function(a, n=6){
    x = file(a, "r")
    y = strsplit  (readLines(a, 1), split=',')[[1]]
    z = read.table(text = readLines(a, n), sep=',', col.names = y);z
}
