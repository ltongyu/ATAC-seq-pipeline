# fastx_toolkit (http://hannonlab.cshl.edu/fastx_toolkit/commandline.html#fastx_trimmer_usage) was used to trim the read length from 150bp to 38bp for beige fat only.

for f in /path/to/fastq/*fastq.gz ; do
	
	zcat $f | fastx_trimmer -f 1 -l 38 -z  -o /path/to/fastq/trim_38/`basename $f .fastq.gz`.trim38.fastq.gz

done


# atactk package (https://atactk.readthedocs.io/en/latest/) was used to trim adapators from paired-end read fastq files. 

for f in /path/to/fastq/trim_38/* ; do
        
        cd $f
        trim_adapters *R1* *R2*

done
