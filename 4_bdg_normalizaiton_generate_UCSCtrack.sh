
# for each individual sample
cd $1

test -r $1.hqaa.bam.macs2_peaks.xls && (cat $1.hqaa.bam.macs2_treat_pileup.bdg | awk -v NTAGS=$(grep 'total tags in treatment' $1.hqaa.bam.macs2_peaks.xls | awk '{print $NF}') '{$4=$4*(10000000/NTAGS); print}' | perl -pe 's/\s+/\t/g; s/$/\n/' | grep -v '_' | LC_COLLATE=C sort -k1,1 -k2,2n > $1_treat_pileup.normalized.bdg)
bedGraphToBigWig $1_treat_pileup.normalized.bdg /path/to/mm10.chrom.sizes $1.broad.peaks.bw

cd ..

# for averaged bedgraph in three bioloigcal replicates for each group
# code is adapted from https://www.biostars.org/p/329080/#
# for cre group
bedtools unionbedg -i /path/to/cre01/cre01_treat_pileup.normalized.bdg /path/to/cre02/cre02_treat_pileup.normalized.bdg  /path/to/cre03/cre03_treat_pileup.normalized.bdg  | awk '{sum=0; for (col=4; col<=NF; col++) sum += $col; print $0"\t"sum/(NF-4+1); }' > /path/to/mean_cre_nml.bdg
awk '{print $1"\t"$2"\t"$3"\t"$7}' mean_cre_nml.bdg > mean_cre_nml.short.bdg
bedGraphToBigWig mean_cre_nml.short.bdg /path/to/mm10.chrom.sizes /path/to/cre.nml.broad.peaks.bw

# for lox group
bedtools unionbedg -i /path/to/lox01/lox01_treat_pileup.normalized.bdg /path/to/lox02/lox02_treat_pileup.normalized.bdg  /path/to/lox03/lox03_treat_pileup.normalized.bdg  | awk '{sum=0; for (col=4; col<=NF; col++) sum += $col; print $0"\t"sum/(NF-4+1); }' > /path/to/mean_lox_nml.bdg
awk '{print $1"\t"$2"\t"$3"\t"$7}' mean_lox_nml.bdg > mean_lox_nml.short.bdg
bedGraphToBigWig mean_lox_nml.short.bdg /path/to/mm10.chrom.sizes /path/to/lox.nml.broad.peaks.bw
