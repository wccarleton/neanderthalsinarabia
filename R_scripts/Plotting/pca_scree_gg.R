#screeplot
ggplot(data = pca_levallois_scree) +
   geom_path(mapping = aes(x = Component, y = Eigenvalues),colour="darkgrey") +
   geom_point(mapping = aes(x = Component, y = Eigenvalues)) +
   coord_cartesian(ylim=c(0,5),
                  xlim=c(1,8),
                  clip="off") +
   scale_x_continuous(breaks=c(1:8)) +
   labs(title="Principle Components") +
   annotate("text",
            x = pca_levallois_scree$Component,
            y = -0.5,
            label = round(pca_levallois_scree$PercentageVariance,3)*100,
            size = 3) +
   annotate("text",
            x = 0.25,
            y = -0.5,
            label = "% Variance",
            size = 3) +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.margin = margin(t = 1, r = 1, b = 1, l = 10, unit = "mm"),
         plot.title = element_text(face="bold",hjust=0.5,size=15),
         axis.title.x.bottom = element_text(margin=margin(t=5,r=1,b=1,l=1, unit ="mm")),
         axis.text.x = element_text(margin=margin(t=8,r=1,b=1,l=1, unit ="mm")))
ggsave(filename="../Images/screeplot.png",
      device = "png",
      dpi="retina")
