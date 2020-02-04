# generate whole genome bg file on different chromosomes, the function is included in atactk package 
fasta-get-markov mm10.fa mm10.bg
# scan PPARg motif in 1-19 chromsome
fimo -bgfile mm10.bg PPARG_mouse.meme mm10.fa

# convert PPARg motif gff to bed file
gff2bed < ./fimo_out/fimo.gff | awk 'BEGIN {IFS="\t"; OFS="\t";} {print $1,$2,$3,$4,$5,$6}' | gzip > wh_PPARg.bed.gz

