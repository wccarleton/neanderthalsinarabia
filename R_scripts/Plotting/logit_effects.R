#plotting the data for the logit model and the model predictions
ggplot(data = logit_fitted,
         aes(y=Probability,x=Score)) +
   geom_ribbon(aes(ymin = LL, ymax = UL),
                  alpha = 0.5,
                  fill = "steelblue1",
                  show.legend=F) +
   geom_line(aes(y = Probability)) +
   geom_point(data = temp,
               aes(x = score, y = SpeciesCode),
               alpha=0.1) +
   facet_wrap(vars(PC),nrow=2, scales="free") +
   labs(title="Logit Model Effects per PC",
         y="Probability") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))
ggsave(filename="../Images/logit_effects.png",
      device = "png",
      dpi="retina")
