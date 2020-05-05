#AUC histogram and density plot
n <- length(rocr_cv_perf_auc$auc)
nbins <- 1 + (3.222 * log(n))
ggplot(data = data.frame(AUC=rocr_cv_perf_auc$auc),
            mapping = aes(x = AUC, stat(density))) +
      geom_histogram(bins=nbins,
                     color="white") +
      labs(x="AUC",
            y="Density",
            title="AUC from Logit Cross Validation") +
      theme_minimal() +
      theme(text = element_text(family="Times", size=12),
            plot.title = element_text(face="bold",hjust=0.5,size=15))

ggsave(filename="../Images/auc_distribution.png",
      device = "png",
      dpi="retina")
