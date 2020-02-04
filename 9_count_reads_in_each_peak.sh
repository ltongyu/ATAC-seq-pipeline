cd $1

coverageBed -counts -sorted -a /path/to/nonblacklist/master_peaks_beige.sorted.bed -b $1.hqaa.bam > /path/to/Rinput/$1.counts.bed

cd ..


cd /path/to/Rinput/
for f in *.counts.bed; do echo $f;awk '{print $1":"$2"-"$3"\t"$4}' $f > $f.Rinput;done
