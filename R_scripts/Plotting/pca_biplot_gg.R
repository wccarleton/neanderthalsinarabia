#biplots
#by site
ggplot(data = pca_scores_levallois) +
   geom_point(mapping = aes(x = PC1, y = PC2, colour = Site)) +
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
ggplot(data = pca_scores_levallois, aes(x = PC1, y = PC2, colour = Species)) +
   geom_point() +
   stat_ellipse(type="norm") +
   stat_ellipse(type="norm",level=0.68,linetype=2) +
   scale_x_continuous(breaks=c(-5:10)) +
   scale_y_continuous(breaks=c(-4:3)) +
   labs(title="PCA Scores") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))
ggsave(filename="../Images/pca_biplot_species.png",
      device = "png",
      dpi="retina")
