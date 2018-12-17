##PCA
library(ggfortify)
head(symbolTab)
Pca <- as.data.frame(t(symbolTab))
Pca$group <- cdata$group
Pca_tab <- as.data.frame(t(symbolTab))
autoplot(prcomp(Pca_tab), data=Pca, colour = "group",
         main = "PCA plot(gene expression)")

head(ssgsea_c3tft)
Pca_gsva <- as.data.frame(t(ssgsea_c3tft))
Pca_gsva_tab <- as.data.frame(t(ssgsea_c3tft))
Pca_gsva$group <- cdata$group
autoplot(prcomp(Pca_gsva_tab), data=Pca_gsva, colour="group",
         main = "PCA plot(ssGSEA)")


##MDS

head(symbolTab) # GeneExp
symbolTab_d <- cmdscale(dist(t(symbolTab)), eig = T, k=2)
symbolTab_d_points <- as.data.frame(symbolTab_d$points)
symbolTab_d_points$group <- cdata$group[1:nrow(cdata)]

ggplot(symbolTab_d_points, aes(x=V1, y=V2,color=group)) +
  geom_point() +
  theme(plot.title = element_text(family = "Trebuchet MS", size=15, hjust = 0, face = "bold")) +
  ggtitle("MDSplot(GeneExpression)") +
  xlab("X") + ylab("Y")

head(ssgsea_c3tft) #ssGSEA
ssgsea_c3tft_d <- cmdscale(dist(t(ssgsea_c3tft)), eig = T, k=2)
ssgsea_c3tft_d_points <- as.data.frame(ssgsea_c3tft_d$points)
ssgsea_c3tft_d_points$group <- cdata$group[1:nrow(cdata)]

ggplot(ssgsea_c3tft_d_points, aes(x=V1, y=V2,color=group)) +
  geom_point() +
  theme(plot.title = element_text(family = "Trebuchet MS", size=15, hjust = 0, face = "bold")) +
  ggtitle("MDSplot(ssGSEA)") +
  xlab("X") + ylab("Y")