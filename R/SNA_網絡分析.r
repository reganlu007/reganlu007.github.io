library(igraph)
load('termDocMatrix.rdata')
termDocMatrix
termDocMatrix[termDocMatrix>=1] = 1
x = termDocMatrix %*% t(termDocMatrix)
x[5:10,5:10]

g = simplify(graph.adjacency(x, weighted=T, mode = 'undirected'))
V(g)$label = V(g)$name
V(g)$degree = degree(g)
set.seed(3952)
plot(g, layout=layout.fruchterman.reingold)
plot(g, layout=layout.kamada.kawai)

V(g)$label.cex = 2.2 * V(g)$degree / max(V(g)$degree)+ .2
V(g)$label.color = rgb(0, 0, .2, .8)
V(g)$frame.color = NA
egam = (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
E(g)$color = rgb(.5, .5, 0, egam)
E(g)$width = egam

plot(g, layout=layout.fruchterman.reingold)
