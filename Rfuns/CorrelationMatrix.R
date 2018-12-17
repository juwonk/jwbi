#####################################################
###### Correlation matrix ###########################
#####################################################


#####################################################
###### Mission 4. correlation matrix ################
#####################################################

## ggpair : GBM + LGG
## ggcorr : each

##### ggpair #####

GBM_symbol_t$group <- "GBM"
LGG_symbol_t$group <- "LGG"
symbol_t<-rbind(GBM_symbol_t,LGG_symbol_t)

install.packages("GGally")
library(GGally)

head(GBM_symbol_t[,genes])
png("results/correlationMatrix/corrMatrix.png", width = 890, height = 700)
ggpairs(symbol_t, columns = genes, aes_string(colour="group", alpha=0.3)
        ,title = "Correlation matrix/corMethod=Spearman/",
        upper = list(continuous = wrap("cor", size=3), corMethod = "spearman"),
        lower = list(continuous = wrap("points", alpha = 0.1), combo = wrap("dot_no_facet", alpha = 0.4)),
        #diag=list(continuous= wrap("bar", colour="blue")),
        axisLabels = "none") +
  theme(legend.position = "none", 
        panel.grid.major = element_blank(), 
        axis.ticks = element_blank(), 
        panel.border = element_rect(linetype = "dashed", colour = "black", fill = NA))



##### ggcorr #####

ggcorr(GBM_symbol_t[,genes], nbreaks = 10)
ggcorr(GBM_symbol_t[,genes], geom = "blank", label = TRUE, hjust = 0.75) +
  geom_point(size = 10, aes(color = coefficient > 0, alpha = abs(coefficient) > 0.7)) +
  scale_alpha_manual(values = c("TRUE" = 0.6, "FALSE" = 0.1)) +
  guides(color = FALSE, alpha = FALSE) +
  ggtitle("GBM") +
  theme(plot.title = element_text(hjust = 0.932, size = 30))

ggcorr(LGG_symbol_t[,genes], geom = "blank", label = TRUE, hjust = 0.75) +
  geom_point(size = 10, aes(color = coefficient > 0, alpha = abs(coefficient) > 0.7)) +
  scale_alpha_manual(values = c("TRUE" = 0.6, "FALSE" = 0.1)) +
  guides(color = FALSE, alpha = FALSE) +
  ggtitle("LGG") +
  theme(plot.title = element_text(hjust = 0.932, size = 30))