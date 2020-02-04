cd $1

coverageBed -counts -sorted -a /path/to/nonblacklist/master_peaks_beige.sorted.bed -b $1.hqaa.bam > /path/to/Rinput/$1.counts.bed

cd ..
