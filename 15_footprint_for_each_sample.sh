#!/bin/bash

# use PPARg as example, the pipeline is the same as CTCF

echo -n "please input a name:"

read f
echo "$f"
echo /path/to/$f/$f.hqaa.bam

make_cut_matrix  -d -b '(36-1500 1)' -p 8 /path/to/$f/$f.hqaa.bam wh_PPARg.bed.gz | gzip -c > ./$f/${f}_wh_PPARg.matrix.gz

# run_centipepde.R and plot_aggregate_matrix.R is included in atactk packages
Rscript run_centipede.R ./$f/${f}_wh_PPARg.matrix.gz wh_PPARg.bed.gz ./$f/${f}_wh_PPARg.centipede.bed.gz



#### take bound
gunzip -c ./$f/${f}_wh_PPARg.centipede.bed.gz | awk 'BEGIN{IFS="\t"; OFS="\t"} $NF > 0.99 {print $1,$2,$3,$4,$5,$6,$NF}' | gzip > ./$f/${f}_wh_PPARg.bound.bed.gz

#### take unbound
gunzip -c ./$f/${f}_wh_PPARg.centipede.bed.gz | awk 'BEGIN{IFS="\t"; OFS="\t"} $NF < 0.99 {print $1,$2,$3,$4,$5,$6,$NF}' | gzip > ./$f/${f}_wh_PPARg.unbound.bed.gz


make_cut_matrix -a -b '(36-1500 1)' -p 8 /path/to/$f/${f}.hqaa.bam ./$f/${f}_wh_PPARg.bound.bed.gz | gzip -c > ./$f/${f}_wh_PPARg.bound.aggregate.matrix.gz
make_cut_matrix -a -b '(36-1500 1)' -p 8 /path/to/$f/${f}.hqaa.bam ./$f/${f}_wh_PPARg.unbound.bed.gz | gzip -c > ./$f/${f}_wh_PPARg.unbound.aggregate.matrix.gz
plot_aggregate_matrix.R ./$f/${f}_wh_PPARg.bound.aggregate.matrix.gz ./$f/${f}_wh_PPARg.unbound.aggregate.matrix.gz “PPARg_${f}_beige” ./$f/${f}_wh_PPARg.pdf

