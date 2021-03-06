library(DESeq2)
directory <-"./Rinput"
sampleFiles <- list.files(directory)
sampleID <- substr(sampleFiles, 1, 5)
sampleType <- substr(sampleFiles, 1, 3)

sampleTable <- data.frame(sampleName=sampleID,fileName=sampleFiles,genotype=sampleType)
# for brown fat DEPeak analysis (PC1 is loaded as convariate)
ddspeak <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable,directory=directory,design=~genotype + covariate) 

# for beige fat DEPeak analysis
ddspeak <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable,directory=directory,design=~genotype)

colData(ddspeak)
summary(ddspeak)
dim(ddspeak)
ddspeak <- ddspeak[rowSums(counts(ddspeak))>=dim(ddspeak)[2],]
ddspeak$genotype
ddspeak$genotype <- factor(ddspeak$genotype,levels=c("lox","cre"))
ddspeak$genotype

ddspeak <- DESeq(ddspeak, betaPrior = T)
ddspeak

res<- results(ddspeak,contrast=c("genotype", "cre", "lox"),alpha=0.1)
summary(res)

all_data_matrix <-counts(ddspeak,normalized=TRUE)
output <- data.frame(all_data_matrix, res[, c('log2FoldChange', 'pvalue', 'padj')])

write.csv(output, file="./ATAC_nml_res.csv")


### heatmap for differential peaks ###
library("RColorBrewer")
library(pheatmap)
colors <- rev(colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(100))
atac_peak <- output [, c(1:6)]
dep <- rownames(atac_peak) [which (output$padj < 0.1) ]
atac_dp <- data.matrix (atac_peak [dep, ])
pheatmap (atac_dp, color = colors, scale = 'row', show_rownames = F )

