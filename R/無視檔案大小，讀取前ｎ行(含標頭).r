read = function(a, n = 5){
    x = file(a, "r")
    y = strsplit  (readLines(x, 1), split=',')[[1]]
    z = read.table(text = readLines(x, n), sep=',', col.names = y); z
}
