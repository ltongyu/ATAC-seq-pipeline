#!/bin/bash

set -e

# drmr:job processors=4 memory=8gb




# ensure the alignments are coordinate-sorted



# the ataqv pipeline is adapted from https://github.com/ParkerLab/ataqv
cd $1
samtools sort -O BAM -o $1.sorted.bam -T $1.bam.sort $1.bam
# create a BAM file of all the original data, with duplicates marked
java -jar /path/to/java/picard.jar MarkDuplicates I=$1.sorted.bam O=$1.md.bam ASSUME_SORTED=true METRICS_FILE=$1.md.bam.markdup.metrics VALIDATION_STRINGENCY=LENIENT

# drmr:wait

# drmr:job processors=1

# index the BAM file with duplicates marked, so we can prune it
samtools index $1.md.bam

# drmr:wait

# extract the properly paired and mapped autosomal reads with good quality
samtools view -b -h -f 3 -F 4 -F 256 -F 1024 -F 2048 -q 30 $1.md.bam chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 > $1.hqaa.bam

# drmr:wait

# Call broad peaks with macs2 (change genome size as needed for your data)
macs2 callpeak -t $1.hqaa.bam -f BAM -n $1.hqaa.bam.macs2 -g 'mm' --nomodel --shift -100 --extsize 200 -B --broad

# drmr:wait
samtools index $1.hqaa.bam
# Run ataqv (to ask how to put library ...)
ataqv --peak-file $1.hqaa.bam.macs2_peaks.broadPeak --tss-file /path/to/mm10.tss.refseq.housekeeping.ortho.bed --metrics-file $1.md.bam.json.gz mouse $1.md.bam > $1.md.bam.ataqv.out

# drmr:wait

mkarv --force $1.md.bam.web $1.md.bam.json.gz
cd ..
cp ./$1/$1.md.bam.json.gz ./json

## consolidate all the samples QC reports ##
mkarv -r calculate session_together *json.gz
