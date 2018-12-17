## GSVA
options(java.parameters = "-Xmx8000m")
library(xlsx)
# c3_tft_v6_0_symbols ## imported Dataset (GMT etc)
## mt: matrix with symbol
## gs: geneset from MsigDB
## methods: "gsva", "ssgsea", ect


# library(GSA)
# gsmt<-GSA.read.gmt()
# gsva(mt, gsmt, method=method, rnaseq=T)

library(clusterProfiler)
gs <- read.gmt() ## data.frame
gs_list <- split.data.frame(gs, gs$ont)
for(i in 1:length(gs_list)){
  gs_list[[i]] <- gs_list[[i]]$gene
}
gsva(mt, gs_list, method=method, rnaseq=T)



##GSEApre
rnkName <- c("RvP","LvP","LvR")
tem <- list()
for(i in 1:length(res)){
  tem[[i]] <- data.frame(symbol = rownames(res[[i]]), FC=res[[i]]$log2FoldChange)
  write.table(tem[[i]], file=paste("data/RNKfile/",rnkName[i],".rnk",sep = ""), col.names = F, row.names = F,
              quote = F, sep = "\t")
}