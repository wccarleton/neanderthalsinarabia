#screeplot
p1 <- ggplot(data = LogitAICs,
         mapping = aes(x = PC, y = AIC)) +
         geom_path(colour="darkgrey") +
         geom_point() +
         scale_x_continuous(breaks=c(1:8)) +
         labs(title="Logit AICs for the first n PCs",
               y="AIC",
               x="First n PCs") +
         annotate("text",
                  x = 1.1,
                  y = 925,
                  label = "Full",
                  size = 5,
                  colour="darkgrey",
                  hjust=0) +
         theme_minimal() +
         theme(text = element_text(family="Times", size=12),
               plot.title = element_text(face="bold",hjust=0.5,size=15),
               axis.title.x = element_blank())

p2 <- ggplot(data = LogitAICs,
         mapping = aes(x = PC, y = AIC)) +
         geom_path(colour="darkgrey") +
         geom_point() +
         coord_cartesian(ylim=c(410,425),
                        xlim=c(1,8)) +
         scale_x_continuous(breaks=c(1:8)) +
         labs(y="AIC",
               x="First n PCs") +
         annotate("text",
                  x = 1.1,
                  y = 425,
                  label = "Zoomed",
                  size = 5,
                  colour="darkgrey",
                  hjust=0) +
         theme_minimal() +
         theme(text = element_text(family="Times", size=12),
               plot.title = element_text(face="bold",hjust=0.5,size=15))

ggarrange(p1,p2,ncol=1,nrow=2)

ggsave(filename="../Images/logit_aics.png",
      device = "png",
      dpi="retina")
