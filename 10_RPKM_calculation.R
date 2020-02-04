names <- read.table('/path/to/nonblacklist/master_peaks.sorted.bed')

file_names <- dir('./Rinput')

file_names <- paste('./Rinput/', file_names, sep ='')
raw_counts <- do.call(cbind,lapply(file_names,read.table))
rownames(raw_counts) <- raw_counts[,1]
raw_counts <- raw_counts[, c(2,4,6,8,10,12)]
raw_counts <- cbind(raw_counts, names[,1:3])
sampleID <- c('cre01', 'cre02', 'cre03', 'lox01', 'lox02', 'lox03')
colnames(raw_counts) <- c(sampleID, 'chr' , 'start', 'end')

# Count up the total reads in a sample and divide that number by 1,000,000 – 
#   this is our “per million” scaling factor.
sum_raw <- apply(raw_counts[1:dim(raw_counts)[1],1:6], MARGIN = 2, sum)/1000000

# Divide the read counts by the “per million” scaling factor.

a = data.frame()
for (i in 1:dim(raw_counts)[1]){
  b = raw_counts[i,1:6]/sum_raw
  a = rbind(a,b)
}

save (a, file ='./RPM_beige.Rda')


# Divide the RPM values by the length of the gene, in kilobases. This gives you RPKM.

peak_len <- (raw_counts$end-raw_counts$start)/1000
b = data.frame(nrow=1:dim(raw_counts)[1])
for (i in 1:6){
  c = a[,i]/peak_len
  b = cbind(b, c)
}
b = b[,2:7]
colnames(b) <- sampleID


rownames(b) <- rownames(raw_counts)
colnames(b) <- sampleID
save(b, file ='./RPKM_beige.Rda')

