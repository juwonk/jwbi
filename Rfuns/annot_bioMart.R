library(biomaRt)
library(SummarizedExperiment)
# basic USAGE
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
listAttributes(mart)
gene_id <- "ENSG00000138271" ##ensembl_gene_id
name = "ensembl_gene_id"
G_list <- getBM(filters = name, attributes = c(name,"hgnc_symbol","entrezgene"),
                values = gene_id, mart = mart)


# input df which is 1st col is Ensembl_id
                              ## name eg) "hgnc_symbol"
annot_bioMart<-function(ExpSet, name){
library(biomaRt)
library(SummarizedExperiment)
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
gene_id <- ExpSet[1]
listAttributes(mart)
G_list <- getBM(filters = name, attributes = c(name,"hgnc_symbol","entrezgene"),
                values = gene_id, mart = mart)
return(G_list)
}



a<-listAttributes(mart)
biomaRt::listMarts()
?getBM


## genbank
ensembl = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
biomart = getBM(attributes = c("refseq_mrna", "embl", "hgnc_symbol"), values = data_ids$`Reporter Database Entry [genbank]`, mart = ensembl)
data$Rep
x = listAttributes(ensembl)
grep("bank", x$description)
head(biomart)



