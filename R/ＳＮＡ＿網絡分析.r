library(data.table);library(magrittr);library(igraph)

門  = fread('門.csv');F_門 = function(x)門[grep(x, 主治醫師代號)][,c(-3,-2,-1)]
門1 = F_門('D31894D58D22CDECC5A55826F57B8DB1A6EE82CC')
門2 = F_門('3495F5EE004CF696D29F9FB0C0240EC3294EBFB9')
門3 = F_門('F01E3845A2DB53B44940D2E256DB96BC48FF1EFB')
門0 = 門[,c(-3,-2,-1)]
SET_門 = function(x)x[,c(28,30,32,48,54,59,63,120,125,131,132,134,151,206,272,342,343,349,356,357,358,359,361,363,370,371,379,402,418,422,423,424,578,596,599,626,690)]

住  = fread('住.csv');F_住 = function(x)住[grep(x, 醫師別)][,c(-3,-2,-1)]
住1 = F_住('E9385CAAB8C5A00B')
住2 = F_住('F4262C7C21D08356')
住3 = F_住('3941BF4DECDAE0F9')
住0 = 住[,c(-3,-2,-1)]
SET_住 = function(x)x[,c(24,26,28,42,47,52,56,87,91,96,97,98,112,149,174,212,213,218,224,225,226,227,229,230,236,237,241,255,267,270,271,272,374,391,393,415,468)]

SNA = function(x, w=T, m='undirected'){x[x>=1]=1; simplify(graph.adjacency(t(x %<>% data.matrix) %*% x, weighted=w, mode=m))}
CFG = function(g, m=cluster_fast_greedy(g),v=degree(g), e=E(g)$weight,l=layout_nicely) plot(m, g, vertex.size=v, edge.width=e, layout=l)
CEN = function(x) data.table(rbind(
  cbind(centr_degree(x)$centralization ,
        centr_clo   (x)$centralization ,
        centr_betw  (x)$centralization ,
        centr_eigen (x)$centralization),
  cbind(centr_degree(x)$res,
        centr_clo   (x)$res,
        centr_betw  (x)$res,
        centr_eigen (x)$vector)))
CC = function(g)c(
	cluster_fast_greedy(g)$algorithm,	modularity(cluster_fast_greedy(g)),
	cluster_label_prop(g)$algorithm,	modularity(cluster_label_prop(g)),
	cluster_leading_eigen(g)$algorithm,	modularity(cluster_leading_eigen(g)),
	cluster_louvain(g)$algorithm,		modularity(cluster_louvain(g)),
	cluster_walktrap(g)$algorithm,		modularity(cluster_walktrap(g)),
	cluster_infomap(g)$algorithm,		modularity(cluster_infomap(g)),
	cluster_optimal(g)$algorithm,		modularity(cluster_optimal(g)))
