readHead = function(x, n=6){
    pt   = file(x, "r")
    name = strsplit  (readLines(pt, 1), split=',')[[1]]
    data = read.table(text = readLines(pt, n), sep=',', col.names = name);data
}
