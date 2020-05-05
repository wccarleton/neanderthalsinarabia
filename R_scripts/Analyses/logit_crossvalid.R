#quick cross validation for the logit model to create a meaningful ROC curve
unknown_sp <- which(pca_scores_levallois$Species=="Unknown")
d <- pca_scores_levallois[-unknown_sp,]
n <- nrow(d)
##repeat many times to get confidence envelope for the ROC curve
##the following code is inefficient, but the rocr ouput needs to be captured
##for use with ggplot instead of rocr's default plots
rocr_cv_perf <- data.frame(r=numeric(),tpr=numeric(),fpr=numeric())
for( j in 1:1000){
   random_sample_index <- base::sample(1:n,n/2)
   d_train <- d[random_sample_index,]
   d_cv <- d[-random_sample_index,]
   logit_levallois_train <- glm(SpeciesCode~PC1+PC2+PC3+PC4,
                                 data=d_train,
                                 family=binomial(link="logit"))
   logit_levallois_cv_pred <- predict(logit_levallois_train,type="response",newdata=d_cv)
   rocr_pred <- prediction(logit_levallois_cv_pred,d_cv$SpeciesCode)
   rocr_perf <- performance(rocr_pred,measure="tpr",x.measure="fpr")
   nn <- length(rocr_perf@x.values[[1]])
   rocr_cv_perf <- rbind(rocr_cv_perf,data.frame(r=rep(j,nn),tpr=rocr_perf@y.values[[1]],fpr=rocr_perf@x.values[[1]]))
}
