#run a simple logit regression on the data using PCA 1 and 2 as predictors
unknown_sp <- which(pca_scores_levallois$Species=="Unknown")
logit_levallois <- glm(SpeciesCode~scale(PC1)+scale(PC2)+scale(PC3)+scale(PC4),
                        data=pca_scores_levallois[-unknown_sp,],
                        family=binomial(link="logit"))
print(summary(logit_levallois))

#predictions for plotting:
PC_pred <- data.frame()
PC <- c()
prediction_x <- c()
for(j in 4:7){
   prediction_range <- range(scale(pca_scores_levallois[-unknown_sp,j]))
   prediction_series <- seq(prediction_range[1],
                           prediction_range[2],
                           0.001)
   print(prediction_range)
   prediction_n <- length(prediction_series)
   if(j == 4){
      prediction_x <- c(prediction_x,prediction_series)
      PC <- c(PC,rep("PC1",prediction_n))
      PC_pred <- data.frame(PC1 = prediction_series,
                              PC2 = 0,
                              PC3 = 0,
                              PC4 = 0)
   }else if(j == 5){
      prediction_x <- c(prediction_x,prediction_series)
      PC <- c(PC,rep("PC2",prediction_n))
      PC_pred <- rbind(PC_pred,data.frame(PC1 = 0,
                                          PC2 = prediction_series,
                                          PC3 = 0,
                                          PC4 = 0))
   }else if(j == 6){
      PC <- c(PC,rep("PC3",prediction_n))
      prediction_x <- c(prediction_x,prediction_series)
      PC_pred <- rbind(PC_pred,data.frame(PC1 = 0,
                                          PC2 = 0,
                                          PC3 = prediction_series,
                                          PC4 = 0))
   }else{
      PC <- c(PC,rep("PC4",prediction_n))
      prediction_x <- c(prediction_x,prediction_series)
      PC_pred <- rbind(PC_pred,data.frame(PC1 = 0,
                                          PC2 = 0,
                                          PC3 = 0,
                                          PC4 = prediction_series))
   }
}

logit_fitted <- predict(logit_levallois,
                        PC_pred,
                        type="link",
                        se.fit=T)

logit_fitted <- cbind(Probability = plogis(logit_fitted$fit),
                      LL = plogis(logit_fitted$fit - (1.96 * logit_fitted$se)),
                      UL = plogis(logit_fitted$fit + (1.96 * logit_fitted$se)))

logit_fitted <- data.frame(PC=PC,Score=prediction_x,logit_fitted)

#predict logit for JKF-1 data
#logit_predict_testdata <- predict(logit_levallois,
#                                    pca_scores_levallois_testdata,
#                                    type="response",
#                                    se.fit=T)
#print(summary(1-logit_predict_testdata$fit))
