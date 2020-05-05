var_names <- c(
"Distal Width",
"Length",
"Medial Width",
"Number of Scars",
"Platform Thickness",
"Platform Width",
"Proximal Width",
"Thickness at Medial")

ggplot(data=pca_levallois_loadings,
      mapping=aes(x=Vars,
                  y=Loading,
                  group=PC,
                  fill=Direction)) +
geom_col() +
geom_line(mapping=aes(y=0),size=0.25) +
facet_grid(rows = vars(PC)) +
scale_x_discrete(labels=var_names) +
theme_minimal() +
theme(text = element_text(family="Times", size=12),
      axis.text.x = element_text(angle=45, hjust=1),
      plot.title = element_text(face="bold",hjust=0.5,size=15))

#ggsave(filename="../Images/pca_loadings.png",
#      device = "png",
#      dpi="retina",
#      width=15,
#      height=20,
#      units="cm",
#      scale=1.25)
