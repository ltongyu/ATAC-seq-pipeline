for f in /path/to/fastq/trim_38/* ; do
        b=`basename $f`
        cd $f
        bwa mem -t 6 /path/to/reference/genome/Mus_musculus_UCSC_2015/UCSC/mm10/Sequence/BWAIndex/version0.6.0/genome.fa *R1*trimmed* *R2*trimmed* | samtools sort -@ 4 -O bam -T $b.trimmed.fq.gz.tmp -o $b.bam -

done
