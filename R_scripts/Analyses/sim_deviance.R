#assume the model is correct
#simulate data
simd <- simulate(logit_levallois,n=1000)

#re-estiamte the model from the simulated data and collect deviance residuals
f <- function(x,d){
   d$SpeciesCode <- x
   glmfit <- glm(SpeciesCode~PC1+PC2+PC3+PC4,
                  data=d,
                  family=binomial(link="logit"))
   deviance_resids <- residuals(glmfit)
   return(deviance_resids)
}

deviance_resids <- apply(simd, 2, f, d=pca_scores_levallois[-unknown_sp,])
