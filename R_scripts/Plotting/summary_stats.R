plotList <- list()
df <- subset(levallois,Species != "Unknown")
n <- nrow(df)
nbins <- 1 + (3.222 * log(n))
formatted_labels <- c("Number of Scars",
                     "Length",
                     "Proximal Width",
                     "Medial Width",
                     "Distal Width",
                     "Thickness at Medial",
                     "Platform Width",
                     "Platform Thickness")
for(j in 1:8){
   column_name <- names(levallois)[j + 3]
   plotList[[j]] <- ggplot(data=df,mapping=aes_string(x=column_name)) +
                  geom_histogram(mapping=aes_string(y="..count.."),
                                 bins=nbins,
                                 colour=NA,
                                 alpha=0.5,
                                 position="identity") +
                  labs(x=formatted_labels[j]) +
                  theme_minimal() +
                  theme(text = element_text(family="Times", size=12),
                        plot.title = element_text(face="bold",hjust=0.5,size=15),
                        axis.title.y = element_blank(),
                        axis.text.y = element_blank())
}
ggarrange(plotlist=plotList,
         ncol=4,
         nrow=2,
         common.legend=1)

ggsave(filename="../Images/lithic_measures.png",
      device = "png",
      dpi="retina",
      width=15,
      height=10,
      units="cm",
      scale=1.5)
