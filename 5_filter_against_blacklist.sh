
cd $1

cat /path/to/mm10.blacklist.bed.gz  | intersectBed -a $1.hqaa.bam.macs2_peaks.broadPeak -b stdin -v > $1.hqaa.broadPeak.noblacklist

cd ..
