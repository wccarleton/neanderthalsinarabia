p1 <- ggplot(data = pca_scores_levallois) +
   #geom_point(mapping = aes(x = PC1, y = PC2, colour = STRegion)) +
   stat_chull(aes(x=PC1,y=PC2,fill=STRegion),alpha=0.2,colour=NA,geom="polygon") +
   scale_x_continuous(breaks=c(-5:10)) +
   scale_y_continuous(breaks=c(-4:3)) +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))

p2 <- ggplot(data = pca_scores_levallois) +
   #geom_point(mapping = aes(x = PC3, y = PC2, colour = STRegion)) +
   stat_chull(aes(x=PC3,y=PC2,fill=STRegion),alpha=0.2,colour=NA,geom="polygon") +
   scale_x_continuous(breaks=c(-5:10)) +
   scale_y_continuous(breaks=c(-4:3)) +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))

fig <- ggarrange(p1,p2,
         ncol=2,
         nrow=1,
         common.legend=1)

annotate_figure(fig,
               top = text_grob("PCA Scores",
                                 family="Times New Roman",
                                 face="bold"),
               fig.lab.pos = "top")

ggsave(filename="../Images/pca_biplot_regions_PC123_poly.png",
      device = "png",
      dpi="retina")
