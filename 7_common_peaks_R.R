ctrl <- read.table ('/path/to/nonblacklist/common_lox', header = T)
x <- as.factor(ctrl$num)
summary(x)

ctrl_common <- ctrl [ which (ctrl$num > 1), 1:3]

LKO <- read.table ('/path/to/nonblacklist/common_cre.v.2', header = T)
y <- as.factor(LKO$num)
summary(y)

LKO_common <- LKO [ which (LKO$num > 1), 1:3]
write.table(ctrl_common, '/path/to/nonblacklist/ctrl_common.v.3', sep="\t", col.names=F, row.names=F, quote = F)
write.table(LKO_common, '/path/to/nonblacklist/LKO_common.v.3', sep="\t", col.names=F, row.names=F, quote = F)
