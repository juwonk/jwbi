
library(GSA)
library(reshape2)

# KEGG.tumor <- GSA::GSA.read.gmt("../../../data/geneSet/msigDB_cancer1500.gmt")
# 
# tumor.gene.list<-KEGG.tumor[1]
# tumor.gene.list<-melt(tumor.gene.list)
# KEGG.tumorGenes <- unique(tumor.gene.list$value)
# KEGG.tumor
# melt(KEGG.tumor[1])
# 
gs
read.gmt
library(clusterProfiler)
gs <- read.gmt("../../../data/geneSet/msigDB_cancer1500.gmt") ## data.frame
gs_list <- split.data.frame(gs, gs$ont)
for(i in 1:length(gs_list)){
  gs_list[[i]] <- gs_list[[i]]$gene
}
gs_list
gsva(mt, gs_list, method=method, rnaseq=T)