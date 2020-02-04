cd /path/to/nonblacklist/
cat *common | sort -k1,1 -k2n,2 | bedtools merge | sort -k1,1V -k2n,2 > master_peaks.bed
bedtools sort -faidx bed_sort_file.txt -i master_peaks.bed > master_peaks.sorted.bed
