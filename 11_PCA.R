# this script is to perform PCA based on RPKM

sampleID <- c('cre01', 'cre02', 'cre03', 'lox01', 'lox02', 'lox03')
sampleType <- substr (sampleID, 1,3)

######start from rpkm normalized data matrix#####
load(file = './RPKM.Rda')

rdl <- t(b)

rdl.pca <- prcomp(rdl,
                 center = T,
                 scale. = T) 

print(rdl.pca)


sum_pca <- summary(rdl.pca)

pca2 <- rdl.pca$x
pca2 <- as.data.frame(pca2)
pca2$group <- as.factor(sampleType)
pdf('./PCA_RPKM.pdf')
plot(pca2$PC1, pca2$PC2, xlab = paste('PC1', sum_pca$importance[2,1]*100,  '%'), ylab = paste('PC2', sum_pca$importance[2,2]*100,  '%'), 
     col = pca2$group, pch =19, cex = 2, main ='PC plot from RPKM')
text(pca2$PC2 ~ pca2$PC1, labels= row.names(pca2), pos = 4, col = 'blue',cex = 1)
dev.off()

save(pca2, file = './PCA_RPKM.Rda')




