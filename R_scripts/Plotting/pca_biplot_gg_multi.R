plotList <- list()
JKF1_hull_coords <- subset(pca_scores_levallois,SpeciesCode==2)[JKF1_hull_index,c(4:6)]
JKF1_hull_centroid <- colMeans(JKF1_hull_coords)
JKF1_hull_centroid <- data.frame(PC1=JKF1_hull_centroid[1],PC2=JKF1_hull_centroid[2],PC3=JKF1_hull_centroid[3])
formatted_labels <- c("Number of Scars",
                     "Length",
                     "Proximal Width",
                     "Medial Width",
                     "Distal Width",
                     "Thickness at Medial",
                     "Platform Width",
                     "Platform Thickness")
PC_combos <- combn(c("PC1","PC2","PC3"),m=2)[,c(1,3)]

for(j in 1:2){
   JKF1_hull_index <- chull(subset(pca_scores_levallois,SpeciesCode==2)[,PC_combos[,j]])
   JKF1_hull_coords <- subset(pca_scores_levallois,SpeciesCode==2)[JKF1_hull_index,PC_combos[,j]]
   JKF1_hull_centroid <- as.data.frame(t(colMeans(subset(pca_scores_levallois,SpeciesCode==2)[,PC_combos[,j]])))

   plotList[[j]] <- ggplot(data=pca_scores_levallois_species,mapping=aes_string(x=PC_combos[1,j],y=PC_combos[2,j])) +
                  stat_density_2d(aes(fill=Species, alpha=stat(level)),
                                 geom="polygon") +
                  geom_polygon(data=JKF1_hull_coords,
                              aes_string(x = PC_combos[1,j], y = PC_combos[2,j]),
                              fill=NA,
                              colour="black") +
                  geom_point(data=JKF1_hull_centroid,
                              aes_string(x = PC_combos[1,j], y = PC_combos[2,j]),
                              shape=21,
                              colour="black") +
                  theme_minimal() +
                  theme(text = element_text(family="Times", size=12),
                        plot.title = element_text(face="bold",hjust=0.5,size=15))
}
fig <- ggarrange(plotlist=plotList,
         ncol=2,
         nrow=1,
         common.legend=1)

annotate_figure(fig,
               top = text_grob("PCA Scores",
                                 family="Times New Roman",
                                 face="bold"),
               fig.lab.pos = "top")

ggsave(filename="../Images/pca_biplot_PC123.png",
      device = "png",
      dpi="retina")
