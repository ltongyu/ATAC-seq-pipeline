cd $1

test -r $1.hqaa.bam.macs2_peaks.xls && (cat $1.hqaa.bam.macs2_treat_pileup.bdg | awk -v NTAGS=$(grep 'total tags in treatment' $1.hqaa.bam.macs2_peaks.xls | awk '{print $NF}') '{$4=$4*(10000000/NTAGS); print}' | perl -pe 's/\s+/\t/g; s/$/\n/' | grep -v '_' | LC_COLLATE=C sort -k1,1 -k2,2n > $1_treat_pileup.normalized.bdg)
bedGraphToBigWig $1_treat_pileup.normalized.bdg /path/to/mm10.chrom.sizes $1.broad.peaks.bw

cd ..
