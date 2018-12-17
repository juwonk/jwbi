#####################################################
############## MA plot ##############################
#####################################################



## MAplot (ggplot)
library(ggplot2)
library(RColorBrewer)
library(colorspace)
library(gplots)
?RColorBrewer

#res 1=DPvsASL, 2=DPlikevsASL, 3=DPlikevsDP
hist(log2(res[[1]]$baseMean+1))

res_df<-list()
ggplot<-list()
selected <- list()
selected_count <- list()
int_n <- list()
int_p <- list()
for(i in 1:3){
  int_p[[i]] <-which(res[[i]]$padj<5*10^-4 & res[[i]]$log2FoldChange>4)
  int_n[[i]] <-which(res[[i]]$padj<5*10^-4 & res[[i]]$log2FoldChange<(-4))
  res_df[[i]] <- as.data.frame(res[[i]])
  res_df[[i]]$Group <- NA
  res_df[[i]][int_p[[i]],]$Group <- "High in DP"
  res_df[[i]][int_n[[i]],]$Group <- "High in ASC"
  
  ggplot[[i]]<-
    ggplot(res_df[[i]]) +
    geom_point(mapping = aes(x=log2(baseMean+1), y=log2FoldChange), size=0.3) +
    geom_point(data = as.data.frame(res[[i]][int_p[[i]],]),
               mapping = aes(x=log2(baseMean+1), y=log2FoldChange),
               colour="red" ,size=0.4) +
    stat_ellipse(data = as.data.frame(res[[i]][int_p[[i]],]),
                 mapping = aes(x=log2(baseMean+1), y=log2FoldChange),
                 colour="red") +
    geom_point(data = as.data.frame(res[[i]][int_n[[i]],]),
               mapping = aes(x=log2(baseMean+1), y=log2FoldChange), size=0.3,
               colour="blue") +
    stat_ellipse(data = as.data.frame(res[[i]][int_n[[i]],]),
                 mapping = aes(x=log2(baseMean+1), y=log2FoldChange),
                 colour="blue")
  
  selected[[i]] <- res_df[[i]][c(int_p[[i]],int_n[[i]]),]
  if(i==1){
    selected_count[[i]] <- as.matrix(symbolTab[c(int_p[[i]],int_n[[i]]),1:6])}
  if(i==2){
    selected_count[[i]] <- as.matrix(symbolTab[c(int_p[[i]],int_n[[i]]),c(1:3,7,8)])}
  if(i==3){
    selected_count[[i]] <- as.matrix(symbolTab[c(int_p[[i]],int_n[[i]]),4:8])}
  
}

library(xlsx)
write.xlsx2(selected[[1]], "results/DEG.0005.l2fc4.xlsx", sheetName = "DP vs ASC" )
write.xlsx2(selected[[2]], "results/DEG.0005.l2fc4.xlsx", sheetName = "DPlike vs ASC", append = T )
write.xlsx2(selected[[3]], "results/DEG.0005.l2fc4.xlsx", sheetName = "DPlike vs DP", append = T )

write.xlsx2(res[[1]], "results/DEG.xlsx", sheetName = "DP vs ASC" )
write.xlsx2(res[[2]], "results/DEG.xlsx", sheetName = "DPlike vs ASC", append = T )
write.xlsx2(res[[3]], "results/DEG.xlsx", sheetName = "DPlike vs DP", append = T )
