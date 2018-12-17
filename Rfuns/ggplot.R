ggplot(forGO, aes(forGO$Symbol, forGO$Count) ) +
  geom_col(aes(fill=forGO$Group), position = "dodge") +
  coord_flip() +
  theme(plot.title = element_text(family = "Trebuchet MS", size=15, hjust = 0, face = "bold"),
        axis.text.y = element_text(angle=0, hjust=1, size = 3)) +
  ggtitle("GSEA with GO") +
  xlab("") + ylab("") +
  scale_fill_discrete(breaks=c("DP","DPlike","ASC"),
                      name="Group")


ggplot(symbolTab_d_points, aes(x=V1, y=V2,color=group)) +
  geom_point(cex=5) +
  theme(plot.title = element_text(family = "Trebuchet MS", size=15, hjust = 0, face = "bold")) +
  ggtitle("Euclidean MDSplot(GeneExpression)") +
  xlab("X") + ylab("Y")