site_levels <- c("1017", "A5", "ANW-3", "BNS", "JQ-1", "MDF-61", "Qafzeh XIX", "Wusta", "JKF-1", "Kebara x", "Ksar Akil 28A", "Tor Faraj")

pca_scores_levallois_temp <- pca_scores_levallois
pca_scores_levallois_temp$Site <- factor(pca_scores_levallois_temp$Site,levels=site_levels)

fill_colours <- c("Sapiens"=rgb(86/255,188/255,194/255,0.75),
            "Unknown"=rgb(0,0,0),
            "Neanderthal"=rgb(232/255,125/255,114/255,0.75))
line_colours <- c("Sapiens"=rgb(86/255,188/255,194/255),
            "Unknown"=rgb(0.5,0.5,0.5),
            "Neanderthal"=rgb(232/255,125/255,114/255))

p1 <- ggplot(pca_scores_levallois_temp,aes(Site,PC1,fill=Species,colour=Species)) +
      scale_fill_manual(values = fill_colours) +
      scale_color_manual(values = line_colours) +
      geom_boxplot() +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
            plot.title = element_text(face="bold",hjust=0.5,size=15),
            axis.text.x = element_blank(),
            axis.title.x = element_blank())

p2 <- ggplot(pca_scores_levallois_temp,aes(Site,PC2,fill=Species,colour=Species)) +
      scale_fill_manual(values = colours) +
      scale_color_manual(values = line_colours) +
      geom_boxplot() +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
            plot.title = element_text(face="bold",hjust=0.5,size=15))

fig <- ggarrange(p1,p2,
         ncol=1,
         nrow=2,
         common.legend=1)

annotate_figure(fig,
               top = text_grob("PCA Score Box Plots",
                                 family="Times New Roman",
                                 face="bold"),
               fig.lab.pos = "top")

ggsave(filename="../Images/pca_box_PC12.png",
      device = "png",
      dpi="retina")
