levallois_data = read.csv("Data/Levallois_flake_data_CORRECTED_v5.csv")
#levallois_data = read.csv("Data/Levallois_flake_data.csv")
levallois_data$SpCode = 0
levallois_data[which(levallois_data$Site == "Tor Faraj"),"SpCode"] <- 1 #Neanderthal
levallois_data[which(levallois_data$Site == "Kebara X"),"SpCode"] <- 1 #Neanderthal
levallois_data[which(levallois_data$Site == "Ksar Akil 28A"),"SpCode"] <- 1 #Neanderthal
#levallois_data[which(levallois_data$Site == "ALM-3"),"SpCode"] <- 2 #unknown
levallois_data[which(levallois_data$Site == "JKF-1"),"SpCode"] <- 2 #unknown
levallois_nona = levallois_data[-which(apply(levallois_data, 1, function(x)any(is.na(x)))),]

var_cols = 3:10

pca_levallois = prcomp(levallois_nona[,var_cols], retx = T, scale = T)

levallois_proj = cbind(levallois_nona, pca_levallois$x)


unknown_sp <- which(levallois_proj$SpCode==2)
logit_levallois <- glm(SpCode~PC1+PC2+PC3+PC3,
                        data=levallois_proj[-unknown_sp,],
                        family=binomial(link="logit"))

logit_predict_JKF1 <- predict(logit_levallois,
    newdata=levallois_proj[which(levallois_proj$Site=="JKF-1"),],
    type="response",
    se.fit=T)

logit_predict_ALM3 <- predict(logit_levallois,
    newdata=levallois_proj[which(levallois_proj$Site=="ALM-3"),],
    type="response",
    se.fit=T)
