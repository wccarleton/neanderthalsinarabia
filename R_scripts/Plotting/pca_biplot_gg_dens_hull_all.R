#biplots
#with density
JKF1_hull_coords <- subset(pca_scores_levallois,SpeciesCode==2)[JKF1_hull_index,c(4,5)]
JKF1_hull_centroid <- colMeans(JKF1_hull_coords)
JKF1_hull_centroid <- data.frame(PC1=JKF1_hull_centroid[1],PC2=JKF1_hull_centroid[2])

my_density <- function (data, mapping, ...)
{
   ggplot(data = data, mapping=mapping) +
   stat_density_2d(aes(fill=Species, alpha=stat(level)), colour=NA, geom="polygon")
}

ggpairs(data = subset(pca_scores_levallois,SpeciesCode != 2),
         columns=4:11,
         mapping=aes(colour=Species,alpha=0.5),
         lower=list(continuous=wrap("points",size=0.01)),
         upper=list(continuous=my_density),
         legend=1) +
   labs(title="PCA Pair Plots and Densities") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))
ggsave(filename="../Images/pca_biplot_species_dens_allPCs.png",
      device = "png",
      dpi="retina",
      height=15,
      width=20,
      units="cm")
