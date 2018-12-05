library(data.table);library(magrittr);library(igraph)

門0 = fread('門.csv')[,c(-3,-2,-1)]
住0 = fread('住.csv')
住1 = 住0[grep('E9385CAAB8C5A00B',醫師別)][,c(-3,-2,-1)]
住2 = 住0[grep('F4262C7C21D08356',醫師別)][,c(-3,-2,-1)]
住3 = 住0[grep('3941BF4DECDAE0F9',醫師別)][,c(-3,-2,-1)]
住0 = 住0[,c(-3,-2,-1)]

SNA = function(x){x[x>=1] = 1; graph.adjacency(t(x %<>% data.matrix) %*% x, weighted = T, mode = 'undirected')%>% simplify %>% return}
PIC = function(g){
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
  plot(g, layout=layout.fruchterman.reingold)
  return(g)
}
