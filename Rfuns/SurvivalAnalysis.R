####################################################
###### Survival Analysis 17.08.09 ##################
####################################################

####################################################
###### Mission 2. KDMs expression Survival #########
####################################################

library(survminer)

genes <- c("JMJD1C", "PHF2", "PHF8", "KDM4A", "KDM4B", "KDM4C", "KDM4D")
data_t <- list()
for(i in 1:2){
  data_t[[i]] <- t(data_raw[[i]])
  colnames(data_t[[i]]) <- colData[[i]]$external_gene_name
}
a<-data_t[[1]]

data_t_genes <- list()
for(i in 1:2){
  data_t_genes[[i]] <- data_t[[i]][,which(colnames(data_t[[i]]) %in% genes)]
}
dim(data_t_genes[[2]])
colnames(data_t_genes[[1]])==colnames(data_t_genes[[2]])
head(data_t_genes[[1]])

#########
## GBM ##
#########

TCGA_GBM_sample<-TCGA_GBM_sample_raw
for (i in 1:ncol(data_t_genes[[1]])){
  quant<-quantile(data_t_genes[[1]][,i])
  TCGA_GBM_sample[which(data_t_genes[[1]][,i] > quant[4]), genes[i]] <- "High"
  TCGA_GBM_sample[which(data_t_genes[[1]][,i] < quant[2]), genes[i]] <- "Low"
}

## survival plot - ggplot2(autoplot)

###################Surv day colume##################
TCGA_GBM_sample$days <- TCGA_GBM_sample$days_to_last_follow_up
TCGA_GBM_sample[!is.na(TCGA_GBM_sample$days_to_death),]$days <- 
  TCGA_GBM_sample[!is.na(TCGA_GBM_sample$days_to_death),]$days_to_death

TCGA_GBM_sample$vital_status_logic <- 1
TCGA_GBM_sample[which(TCGA_GBM_sample$vital_status=="alive"),"vital_status_logic"] <- 0
####################################################

## survival plot - ggplot2(autoplot)
for(i in 1:length(genes)){
  a<-genes[i]
  fit<-survfit(Surv(TCGA_GBM_sample$days, event = TCGA_GBM_sample$vital_status_logic) ~ TCGA_GBM_sample[,a], data = TCGA_GBM_sample)
  png(filename = paste("results/SurvivalCurves/SurvivalCurve_GBM_", genes[i], "_0.25.png",sep = ""))
  print(ggsurvplot(fit, legend = c(0.8, 0.8), risk.table = T, 
                   legend.title = genes[i], legend.labs = c("High", "Low"), 
                   pval = T, break.time.by = 500, title = "Survival curve 0.25"))
  dev.off()
}

#########
## LGG ##
#########

dim(TCGA_LGG_sample_raw)
TCGA_LGG_sample<-TCGA_LGG_sample_raw
for (i in 1:ncol(data_t_genes[[2]])){
  quant<-quantile(data_t_genes[[2]][,i])
  TCGA_LGG_sample[which(data_t_genes[[2]][,i] > quant[4]), genes[i]] <- "High"
  TCGA_LGG_sample[which(data_t_genes[[2]][,i] < quant[2]), genes[i]] <- "Low"
}
dim(TCGA_LGG_sample)

## survival plot - ggplot2(autoplot)

###################Surv day colume##################
TCGA_LGG_sample$days <- TCGA_LGG_sample$days_to_last_follow_up
TCGA_LGG_sample[!is.na(TCGA_LGG_sample$days_to_death),]$days <- 
  TCGA_LGG_sample[!is.na(TCGA_LGG_sample$days_to_death),]$days_to_death

TCGA_LGG_sample$vital_status_logic <- 1
TCGA_LGG_sample[which(TCGA_LGG_sample$vital_status=="alive"),"vital_status_logic"] <- 0
####################################################

table(TCGA_LGG_sample$vital_status_logic)
Surv(TCGA_LGG_sample$days, event = TCGA_LGG_sample$vital_status_logic)
for(i in 1:length(genes)){
  a<-genes[i]
  fit<-survfit(Surv(TCGA_LGG_sample$days, event = TCGA_LGG_sample$vital_status_logic) ~ TCGA_LGG_sample[,a], data = TCGA_LGG_sample)
  png(filename = paste("results/SurvivalCurves/SurvivalCurve_LGG_", genes[i], "_0.25.png",sep = ""))
  print(ggsurvplot(fit, legend = c(0.8, 0.8), risk.table = T, 
                   legend.title = genes[i], legend.labs = c("High", "Low"), 
                   pval = T, break.time.by = 500, title = "Survival curve 0.25"))
  dev.off()
}