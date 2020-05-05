#biplots
#by site
ggplot(data = pca_scores_levallois) +
   geom_point(mapping = aes(x = PC1, y = PC2, colour = Site)) +
   stat_chull(aes(x=PC1,y=PC2,colour=Site)) +
   scale_x_continuous(breaks=c(-5:10)) +
   scale_y_continuous(breaks=c(-4:3)) +
   labs(title="PCA Scores") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))
ggsave(filename="../Images/pca_biplot_sites.png",
      device = "png",
      dpi="retina")

#by species
ggplot(data = pca_scores_levallois_species, aes(x = PC1, y = PC2, colour = Species)) +
   geom_point() +
   stat_ellipse(type="norm",linetype=2) +
   stat_ellipse(type="norm",level=0.68) +
   geom_point(data=pca_scores_levallois[which(pca_scores_levallois$Species=="Unknown"),],
               aes(x = PC1, y = PC2, colour=Site)) +
   scale_x_continuous(breaks=c(-5:10)) +
   scale_y_continuous(breaks=c(-4:3)) +
   labs(title="PCA Scores") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))
ggsave(filename="../Images/pca_biplot_species.png",
      device = "png",
      dpi="retina")

#with density
JKF1_hull_coords <- subset(pca_scores_levallois,SpeciesCode==2)[JKF1_hull_index,c(4,5)]
JKF1_hull_centroid <- colMeans(JKF1_hull_coords)
JKF1_hull_centroid <- data.frame(PC1=JKF1_hull_centroid[1],PC2=JKF1_hull_centroid[2])
ggplot(data = pca_scores_levallois_species, aes(x = PC1, y = PC2)) +
   stat_density_2d(aes(fill=Species, alpha=stat(level)),
                  geom="polygon") +
   geom_polygon(data=subset(pca_scores_levallois,SpeciesCode==2)[JKF1_hull_index,c(4,5)],
               aes(x = PC1, y = PC2),
               fill=NA,
               colour="black") +
   geom_point(data=JKF1_hull_centroid,
               aes(x = PC1, y = PC2),
               shape=21,
               colour="black") +
   scale_x_continuous(breaks=c(-5:10)) +
   scale_y_continuous(breaks=c(-4:3)) +
   labs(title="PCA Scores") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))
ggsave(filename="../Images/pca_biplot_species_dens.png",
      device = "png",
      dpi="retina")
