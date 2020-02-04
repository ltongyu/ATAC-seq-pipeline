rm(list=ls())
### lox vs cre #### 


sample_names <- dir('./TF_footprint/PPARg')
all_matrix <- data.frame (data.matrix(0))
for (i in 1: length (sample_names)){
  sample_dir <- dir(paste0 ('./TF_footprint/PPARg/', sample_names [i]))
  file_names <- sample_dir [grep ('bound.aggregate.matrix', sample_dir)]
  
  x <- read.delim (file = paste0 ('./TF_footprint/PPARg/', sample_names [i], '/', file_names [1]))
  y <- read.delim (file = paste0 ('./TF_footprint/PPARg/', sample_names [i], '/', file_names [2]))
  all_matrix <- cbind(all_matrix, x$MeanCutPointCount, y$MeanCutPointCount)
  
}
all_matrix <- all_matrix [, -1]
colnames (all_matrix) <- paste (rep (sample_names, each = 2), c('bound', 'unbound'), sep = '_')

all_matrix <- cbind(x [, c('Position', 'Strand')], all_matrix)

# total_read file was obtained from ataqv output. I manually organized QC reports to one .csv file. 

total_read <- read.csv('./all_ataqv.csv')
total_read <- total_read[, c('Name', 'Total.reads')]
a <- total_read$Total.reads
a <- as.character (a)
a <- as.numeric(a)

# lox forward 
lox.F.matrix <- all_matrix[which(all_matrix$Strand %in% 'F'), c(1:2, grep('lox', colnames(all_matrix)))]
lox.F.bound.matrix <- lox.F.matrix[, grep('_bound', colnames(lox.F.matrix))]
lox.F.unbound.matrix <- lox.F.matrix[, grep('unbound', colnames(lox.F.matrix))]
lox.F.bound.nml <- lox.F.bound.matrix/lox.F.unbound.matrix
lox.F.bound.nml.average2total <- t(t(lox.F.bound.nml)/total_read[6:10,2]*100000000)
lox.F.bound.nml.average2total.avg <- apply(lox.F.bound.nml.average2total, MARGIN = 1, mean)

# lox reverse
lox.R.matrix <- all_matrix[which(all_matrix$Strand %in% 'R'), c(1:2, grep('lox', colnames(all_matrix)))]
lox.R.bound.matrix <- lox.R.matrix[, grep('_bound', colnames(lox.R.matrix))]
lox.R.unbound.matrix <- lox.R.matrix[, grep('unbound', colnames(lox.R.matrix))]
lox.R.bound.nml <- lox.R.bound.matrix/lox.R.unbound.matrix
lox.R.bound.nml.average2total <- t(t(lox.R.bound.nml)/total_read[6:10,2]*100000000)
lox.R.bound.nml.average2total.avg <- apply(lox.R.bound.nml.average2total, MARGIN = 1, mean)


lox.po.F <- as.numeric(as.character(lox.F.matrix[,1]))
lox.po.R <- as.numeric(as.character(lox.R.matrix[,1]))


# cre forward

cre.F.matrix <- all_matrix[which(all_matrix$Strand %in% 'F'), c(1:2, grep('cre', colnames(all_matrix)))]

cre.F.bound.matrix <- cre.F.matrix[, grep('_bound', colnames(cre.F.matrix))]
cre.F.unbound.matrix <- cre.F.matrix[, grep('unbound', colnames(cre.F.matrix))]
cre.F.bound.nml <- cre.F.bound.matrix/cre.F.unbound.matrix
cre.F.bound.nml.average2total <- t(t(cre.F.bound.nml [, 1:3])/total_read[1:3,2]*100000000) ### for cre total reads
cre.F.bound.nml.average2total.avg <- apply(cre.F.bound.nml.average2total, MARGIN = 1, mean)


# cre reverse
cre.R.matrix <- all_matrix[which(all_matrix$Strand %in% 'R'), c(1:2, grep('cre', colnames(all_matrix)))]

cre.R.bound.matrix <- cre.R.matrix[, grep('_bound', colnames(cre.R.matrix))]
cre.R.unbound.matrix <- cre.R.matrix[, grep('unbound', colnames(cre.R.matrix))]
cre.R.bound.nml <- cre.R.bound.matrix/cre.R.unbound.matrix
cre.R.bound.nml.average2total <- t(t(cre.R.bound.nml [,1:3])/total_read[1:3,2]*100000000)
cre.R.bound.nml.average2total.avg <- apply(cre.R.bound.nml.average2total, MARGIN = 1, mean)


cre.po.F <- as.numeric(as.character(cre.F.matrix[,1]))
cre.po.R <- as.numeric(as.character(cre.R.matrix[,1]))


pdf('./TF_footprint/PPARg_fp_slct_sp.pdf')
plot (lox.po.F, lox.F.bound.nml.average2total.avg, type="l",main = 'PPARg in lox vs cre footprint',
      ylab = 'cut point counts', xlab = 'postion (bp)', ylim = c(0,15))
lines (lox.po.R, lox.R.bound.nml.average2total.avg, type="l", lty=3)
lines (cre.po.F, cre.F.bound.nml.average2total.avg, type="l", col = 'blue')
lines (cre.po.R, cre.R.bound.nml.average2total.avg, type="l", col = 'blue', lty = 3)
legend(60,15, legend = c('lox-F','lox-R', 'cre-F', 'cre-R'), lty = c(1,3,1,3), col = c('black', 'black', 'blue', 'blue'))
dev.off()
