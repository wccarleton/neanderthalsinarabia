#plotting multiple ROC curves from CV analysis
ggplot(data = rocr_cv_perf,
         aes(y=tpr,x=fpr,group=r)) +
   geom_line(alpha=0.01) +
   geom_line(data=data.frame(x=seq(0,1,0.001),y=seq(0,1,0.001)),
            aes(x=x,y=y),
            linetype=2,
            colour="grey",
            inherit.aes=F) +
   labs(title="ROC Curves from Logit Cross Validation",
         y="TPR",
         x="FPR") +
   theme_minimal() +
   theme(text = element_text(family="Times", size=12),
         plot.title = element_text(face="bold",hjust=0.5,size=15))
ggsave(filename="../Images/logit_cv_roc.png",
      device = "png",
      dpi="retina")
