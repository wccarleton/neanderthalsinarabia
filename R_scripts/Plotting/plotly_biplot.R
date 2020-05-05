p <- plot_ly(pca_scores_levallois, x = pca_scores_levallois$PC1, y = pca_scores_levallois$PC2, z = pca_scores_levallois$PC3, text = pca_scores_levallois[,1], mode = "markers", color = pca_scores_levallois$Species, marker = list(size = 11))

p <- layout(p, title = "PCA Biplot for Levallois Data",
       xaxis = list(title = "PC 1"),
       yaxis = list(title = "PC 2"))

chart_link = api_create(p, filename="NeanderTool_3PCA")
chart_link
