library(data.table);library(magrittr);library(igraph)

a = fread('門0.csv')[,c(-2,-1)]
b = fread('住0.csv')[,c(-3,-2,-1)]

SNA = function(x){x[x>=1] = 1; graph.adjacency(t(x %<>% data.matrix) %*% x, weighted = T, mode = 'undirected')%>% simplify %>% return}
PIC = function(g){
  V(g)$label  = V(g)$name
  V(g)$degree = degree(g)
  set.seed(1)
  plot(g, layout=layout.kamada.kawai)
  return(g)
}
PIC_2 = function(g){
  g = PIC(g)
  V(g)$label.cex   = 2.2 * V(g)$degree / max(V(g)$degree)+ .2
  V(g)$label.color = rgb(0, 0, .2, .8)
  V(g)$frame.color = NA
  egam = (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
  E(g)$color = rgb(.5, .5, 0, egam)
  E(g)$width = egam
  plot(g, layout=layout.fruchterman.reingold)
  return(g)
}
