####################################################
###### Expression compare between group ############
####################################################

####################################################
###### Mission 1. KDM expression GBM vs LGG ########
####################################################

### 
data_raw <- list()
data_raw[[1]]<-as.data.frame(TCGA_GBM_assay)
data_raw[[2]]<-as.data.frame(TCGA_LGG_assay)
colData <- list()
colData[[1]] <- TCGA_GBM_gene
colData[[2]] <- TCGA_LGG_gene   
which(colData[[2]]$external_gene_name %in% c("JMJD1C", "PHF2", "PHF8", "KDM4A", "KDM4B", "KDM4C", "KDM4D"))
## normalization
for(j in 1:2){
  m<-mean(colMeans(data_raw[[j]]))
  for(i in 1:ncol(data_raw[[j]])){
    m2<-colMeans(data_raw[[j]][i])
    data_raw[[j]][i]<-data_raw[[j]][i]*m/m2
  }
}
## normalization check
colMeans(data_raw[[1]])
data <- data_raw
KDMs<-list()
for(i in 1:2){
  data[[i]]$symbol <- colData[[i]]$external_gene_name
  KDMs[[i]] <- data[[i]][which(data[[i]]$symbol %in% c("JMJD1C", "PHF2", "PHF8", "KDM4A", "KDM4B", "KDM4C", "KDM4D")),]
  rownames(KDMs[[i]]) <- KDMs[[i]]$symbol
  KDMs[[i]] <- KDMs[[i]][,1:(ncol(data[[i]])-1)]
}
colnames(KDMs[[1]])<-replicate(ncol(KDMs[[1]]), "GBM")  #paste("GBM", 1:ncol(KDMs[[1]]),sep = "_")
colnames(KDMs[[2]])<-replicate(ncol(KDMs[[2]]), "LGG")  #paste("LGG", 1:ncol(KDMs[[2]]),sep = "_")
dim(KDMs[[1]])

table(rownames(KDMs[[1]])==rownames(KDMs[[2]]))

KDMs_table<-cbind(KDMs[[1]], KDMs[[2]])
KDMs_table$symbols <- rownames(KDMs_table)
KDMs_melted<-melt(KDMs_table)
KDMs_melted$variable <- factor(KDMs_melted$variable, levels = c("GBM", "LGG"))

ggplot(KDMs_melted, aes(x=KDMs_melted$symbols, y=KDMs_melted$value)) +
  geom_col(aes(fill=KDMs_melted$variable), position = "dodge") +
  ggtitle("GBM(174) vs LGG(529) on KDMs") +
  xlab("Genes") + ylab("mean(counts)") +
  scale_fill_discrete(name="Group")