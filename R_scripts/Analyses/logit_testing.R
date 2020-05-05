logit_levallois <- glm(SpeciesCode~PC1+PC2+PC3+PC4+PC5+PC6+PC7+PC8,
                        data=pca_scores_levallois[-unknown_sp,],
                        family=binomial(link="logit"))
print(summary(logit_levallois))

logit_levallois_sum <- summary(logit_levallois)

#collect AICs
AICs <- c()
xs <- c("PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8")
for(j in 1:8){
   f <- as.formula(paste("SpeciesCode~",paste(xs[1:j],collapse="+")))
   logit_levallois <- glm(f,
                           data=pca_scores_levallois[-unknown_sp,],
                           family=binomial(link="logit"))
   AICs <- c(AICs,logit_levallois$aic)
}

LogitAICs <- data.frame(PC=1:8,AIC=round(AICs,0))
