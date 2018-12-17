# reference 
# https://rpubs.com/gaston/dendrograms



## 1. color dendrogram
# load code of A2R function
source("http://addictedtor.free.fr/packages/A2R/lastVersion/R/code.R")
# colored dendrogram
op = par(bg = "#EFEFEF")
A2Rplot(hc, k = 3, boxes = FALSE, col.up = "gray50", col.down = c("#FF6B6B", 
                                                                  "#4ECDC4", "#556270"))


## 2-1. ggdendro
# install.packages('ggdendro')
library(ggdendro)
# basic option
ggdendrogram(hc)
## 2-2. horizantal
ggdendrogram(hc, rotate = TRUE, size = 4, theme_dendro = FALSE, color = "tomato")



## 3. color in leaves
# install.packages('sparcl')
library(sparcl)
# colors the leaves of a dendrogram
y = cutree(hc, 3)
ColorDendrogram(hc, y = y, labels = names(y), main = "My Simulated Data", 
                branchlength = 80)


