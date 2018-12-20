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

SNA = function(x,w=T,m='undirected'){
  x[x>=1]=1; simplify(graph.adjacency(t(x %<>% data.matrix) %*% x, weighted=w, mode=m))}
CFG = function(g, v=degree(g)/max(degree(g))*25, e=E(g)$weight/max(E(g)$weight)*5,l=layout.circle)
  plot(cluster_fast_greedy(g), g, vertex.size=v, edge.width=e, layout=l)
CEN = function(x) data.table(rbind(
  cbind(centr_degree(x)$centralization ,
        centr_clo   (x)$centralization ,
        centr_betw  (x)$centralization ,
        centr_eigen (x)$centralization),
  cbind(centr_degree(x)$res,
        centr_clo   (x)$res,
        centr_betw  (x)$res,
        centr_eigen (x)$vector)))
