ggplot(data=pca_scores_levallois,mapping=aes(x=PC1,y=Weight)) +
geom_smooth(method="lm",formula= y~x) +
geom_point() +
scale_y_continuous(trans='log10') +
labs(title="Weight vs PC1",
      y=expression(paste("log"[10],"(Weight)",sep=""))) +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      plot.title = element_text(face="bold",hjust=0.5,size=15))

ggsave(filename="../Images/PC1_flake_size.png",
      device = "png",
      dpi="retina")
