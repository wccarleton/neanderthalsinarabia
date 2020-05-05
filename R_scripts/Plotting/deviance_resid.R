#deviance residual histogram and density plot
d1 <- data.frame(DevianceResidual=residuals(logit_levallois))
d2 <- data.frame(DevianceResidual=as.vector(deviance_resids))
#Sturges bins
n <- nrow(d1)
nbins <- 1 + (3.222 * log(n))
p1 <- ggplot(data = d,
            mapping = aes(x = DevianceResidual, stat(density))) +
      geom_histogram(bins=nbins,
                     color="white") +
      scale_x_continuous(breaks=c(-4:4)) +
      coord_cartesian(xlim=c(-4,4)) +
      labs(title="Deviance Residual Distribution",
            subtitle="Observed") +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
            plot.title = element_text(face="bold",hjust=0.5,size=15),
            plot.subtitle = element_text(face="italic",hjust=0.5,size=10),
            axis.title.x = element_blank())

#Sturges bins
n <- nrow(d2)
nbins <- 1 + (3.222 * log(n))
p2 <- ggplot(data = d2,
            mapping = aes(x = DevianceResidual, stat(density))) +
      geom_histogram(bins=nbins,
                     color="white") +
      scale_x_continuous(breaks=c(-4:4)) +
      coord_cartesian(xlim=c(-4,4)) +
      labs(subtitle="Simulated") +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
            plot.title = element_text(face="bold",hjust=0.5,size=15),
            plot.subtitle = element_text(face="italic",hjust=0.5,size=10))

plot_grid(p1,p2,ncol=1,nrow=2,align="v")

ggsave(filename="../Images/deviance_residual_distribution.png",
      device = "png",
      dpi="retina")
