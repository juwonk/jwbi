#####################################################
###### Heatmap.2 ####################################
#####################################################

library(gplots)
library(RColorBrewer)
heatmap.2(HM_mt,
          main = "Heatmap",
          trace = "none",
          Colv = F,
          cexRow = 0.1,
          cexCol = 1,
          srtCol=45,
          col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(50),
          breaks = seq(-1,1,length.out = 51),
          dendrogram = "row",
          keysize = 1.0,
          key.title = "z-score of log2(Htseq-count)",
          key.par = list(cex=0.5),
          margins = c(5,5),
          ColSideColors = )


#####################################################
###### Heatmap.2 ########## + label #################
#####################################################


library(gplots)
library(RColorBrewer)

CSC <- character()
for(i in 1:length(cdata_braf$`Characteristics [braf status]`)){
  if(cdata_braf$`Characteristics [braf status]`[i] == unique(cdata_braf$`Characteristics [braf status]`)[1]){
    CSC[i] <- "green"} 
  if(cdata_braf$`Characteristics [braf status]`[i] == unique(cdata_braf$`Characteristics [braf status]`)[2])
  {CSC[i] <- "grey"}
  if(cdata_braf$`Characteristics [braf status]`[i] == unique(cdata_braf$`Characteristics [braf status]`)[3])
  {CSC[i] <- "black"}
  if(cdata_braf$`Characteristics [braf status]`[i] == unique(cdata_braf$`Characteristics [braf status]`)[4])
  {CSC[i] <- "white"}
}

pdf("A170821/results/output.pdf", width = 10,height = 5)
heatmap.2(ssGSEA_braf,
          main = "ssGSEA_braf_Angiogenesis Gene Set",
          trace = "none",
          Colv = T,
          Rowv = F,
          cexRow = 0.4,
          cexCol = 0.2,
          srtCol=45,
          col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(50),
          breaks = seq(-0.5,0.5,length.out = 51),
          #dendrogram = "row",
          keysize = 1.0,
          key.title = "ssGSEA",
          key.par = list(cex=0.5),
          margins = c(4,15),
          ColSideColors = CSC)
legend(y=0.9, x=0, xpd=TRUE,
       legend = unique(cdata_braf$`Characteristics [braf status]`),
       col = unique(CSC),
       lty= 1,             
       lwd = 5,           
       cex=.7)
dev.off()