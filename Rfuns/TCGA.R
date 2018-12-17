library(TCGAbiolinks)
BiocInstaller::biocLite("mygene")
library(ReactomePA)
library(mygene)

# normalization of genes
d_nor <- TCGAanalyze_Normalization(tabDF = dataBRCA, geneInfo = geneInfo)

# filtering
qf <- TCGAanalyze_Filtering(tabDF = d_nor, method = "quantile", qnt.cut = 0.25)

# patient grouping
pat_normal <- TCGAquery_SampleTypes(barcode = colnames(qf), typesample = c("NT"))
pat_tumor <- TCGAquery_SampleTypes(barcode = colnames(qf), typesample = "TP")

dataDEG <- TCGAanalyze_DEA(mat1 = qf[,pat_normal], mat2 = qf[,pat_tumor], Cond1type = "Normal", Cond2type = "Tumor",
                           fdr.cut = 0.01, logFC.cut = 1, method = "glmLRT")
head(dataDEG)

#
symbols<-sample(rownames(dataDEG), 10)
ent<-queryMany(symbols, scopes = "symbol", fields="entrezgene", species = "human")
ent<-na.omit(ent$entrezgene)
enrich_result <- enrichPathway(gene = ent, pvalueCutoff = 0.05, readable = T)
enrich_result
a<-as.data.frame(enrich_result)
enrichMap(enrich_result , layout= igraph::layout.kamada.kawai, vertex.label.cex = 1)
enrichMap()

#










sample.types <- c("TP", "TR", "TB", "TRBM", "TAP", "TM", "TAM", "THOC", "TBM", "NB", "NT", "NBC", "NEBV", "NBM")
TCGA_GBM
int<-list()
for(i in 1:length(sample.types)){
int[[i]] <- substring(text = TCGAquery_SampleTypes(barcode = colnames(TCGA_GBM), typesample = sample.types[[i]]),
                      first = 1, last = 12)
}
int
?TCGAquery_SampleTypes
int[[2]] %in% int[[1]]
a<-colData(TCGA_GBM)
c<-table(a$shortLetterCode)
class(c)
b<-colData(TCGA_LGG)
table(b$shortLetterCode)
table(duplicated(substring(text = colnames(TCGA_LGG), first = 1, last = 12)))


