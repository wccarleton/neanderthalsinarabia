#run a simple logit regression on the data using PCA 1 and 2 as predictors
unknown_sp <- which(pca_scores_levallois$Sp=="unknown")
logit_levallois <- glm(Sp~PC1+PC2+PC3+PC4,
                        data=pca_scores_levallois[-unknown_sp,],
                        family=binomial(link="logit"))
print(summary(logit_levallois))

#predictions for plotting:
PC_pred <- data.frame()
PC <- c()
prediction_x <- c()
for(j in 4:7){
   prediction_range <- range(pca_scores_levallois[-unknown_sp,j])
   prediction_series <- seq(prediction_range[1],
                           prediction_range[2],
                           0.001)
   prediction_n <- length(prediction_series)
   if(j == 4){
      prediction_x <- c(prediction_x,prediction_series)
      PC <- c(PC,rep("PC1",prediction_n))
      PC_pred <- data.frame(PC1 = prediction_series,
                              PC2 = mean(pca_scores_levallois[-unknown_sp,]$PC2),
                              PC3 = mean(pca_scores_levallois[-unknown_sp,]$PC3),
                              PC4 = mean(pca_scores_levallois[-unknown_sp,]$PC4))
   }else if(j == 5){
      prediction_x <- c(prediction_x,prediction_series)
      PC <- c(PC,rep("PC2",prediction_n))
      PC_pred <- rbind(PC_pred,data.frame(PC1 = mean(pca_scores_levallois[-unknown_sp,]$PC1),
                                          PC2 = prediction_series,
                                          PC3 = mean(pca_scores_levallois[-unknown_sp,]$PC3),
                                          PC4 = mean(pca_scores_levallois[-unknown_sp,]$PC4)))
   }else if(j == 6){
      PC <- c(PC,rep("PC3",prediction_n))
      prediction_x <- c(prediction_x,prediction_series)
      PC_pred <- rbind(PC_pred,data.frame(PC1 = mean(pca_scores_levallois[-unknown_sp,]$PC1),
                                          PC2 = mean(pca_scores_levallois[-unknown_sp,]$PC2),
                                          PC3 = prediction_series,
                                          PC4 = mean(pca_scores_levallois[-unknown_sp,]$PC4)))
   }else{
      PC <- c(PC,rep("PC4",prediction_n))
      prediction_x <- c(prediction_x,prediction_series)
      PC_pred <- rbind(PC_pred,data.frame(PC1 = mean(pca_scores_levallois[-unknown_sp,]$PC1),
                                          PC2 = mean(pca_scores_levallois[-unknown_sp,]$PC2),
                                          PC3 = mean(pca_scores_levallois[-unknown_sp,]$PC3),
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

##predict logit for JKF-1 data
JKF1 = pca_scores_levallois[which(pca_scores_levallois$Site == "JKF-1"),]
logit_predict_JKF1 <- predict(logit_levallois,
                                    newdata=JKF1,
                                    type="response",
                                    se.fit=T)
print(summary(logit_predict_JKF1))

ALM3 = pca_scores_levallois[which(pca_scores_levallois$Site == "ALM-3"),]
logit_predict_ALM3 <- predict(logit_levallois,
                                    newdata=ALM3,
                                    type="response",
                                    se.fit=T)
print(summary(logit_predict_ALM3))
