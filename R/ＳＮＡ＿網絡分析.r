library(data.table);library(magrittr);library(igraph)

門  = fread('門.csv');F_門 = function(x)門[grep(x, 主治醫師代號)][,c(-3,-2,-1)]
門1 = F_門('D31894D58D22CDECC5A55826F57B8DB1A6EE82CC')
門2 = F_門('3495F5EE004CF696D29F9FB0C0240EC3294EBFB9')
門3 = F_門('F01E3845A2DB53B44940D2E256DB96BC48FF1EFB')
門0 = 門[,c(-3,-2,-1)]

住  = fread('住.csv');F_住 = function(x)住[grep(x, 醫師別)][,c(-3,-2,-1)]
住1 = F_住('E9385CAAB8C5A00B')
住2 = F_住('F4262C7C21D08356')
住3 = F_住('3941BF4DECDAE0F9')
住0 = 住[,c(-3,-2,-1)]

SNA = function(x){x[x>=1] = 1; return(simplify(graph.adjacency(t(x %<>% data.matrix) %*% x, weighted = T, mode = 'undirected')))}
PIC = function(g = SNA(g)){
  V(g)$label  = V(g)$name
  V(g)$degree = degree(g)
  set.seed(1)
  plot(g, layout=layout.kamada.kawai)
  return(g)
}
PIC_2 = function(g = PIC(g)){
  V(g)$label.cex   = 2.2 * V(g)$degree / max(V(g)$degree)+ .2
  V(g)$label.color = rgb(0, 0, .2, .8)
  V(g)$frame.color = NA
  egam = (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
  E(g)$color = rgb(.5, .5, 0, egam)
  E(g)$width = egam
  plot(g, layout=layout.kamada.kawai)
  return(g)
}
FG = function(x)plot(cluster_fast_greedy(x),x)
