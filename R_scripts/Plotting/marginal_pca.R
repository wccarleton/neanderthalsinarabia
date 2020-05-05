#marginal histograms
df <- gather(pca_scores_levallois_species[,-6],key="PC",value="Score",c("PC1","PC2"))#pca_scores_levallois_species
#Sturges bins
n <- nrow(df)
nbins <- 1 + (3.222 * log(n))
ggplot(data = df,
         mapping = aes(x = Score)) +
   geom_histogram(bins=nbins,
                  color="white") +
   facet_grid(rows = vars(PC), cols = vars(Species)) +
   labs(title="PCA Score Distributions") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))



ggsave(filename="../Images/pca_hist_species.png",
      device = "png",
      dpi="retina")
