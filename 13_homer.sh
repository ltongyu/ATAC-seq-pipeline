# annonate all the peaks to the nearest gene by homer based on coordinates of transcription start site. 
annotatePeaks.pl /path/to/master_peaks.sorted.bed mm10 > /path/to/homer/homer.output

# homer motif analysis, input is the bed file of differentially expressed peaks or all the peaks
findMotifsGenome.pl /path/to/DEPeak_up.bed mm10 /path/to/homer/motif_scan/homer_DEPeak_up -size given
findMotifsGenome.pl /path/to/DEPeak_down.bed mm10 /path/to/homer/motif_scan/homer_DEPeak_down -size given
findMotifsGenome.pl /path/to/nonblacklist/master_peaks.sorted.bed mm10  /path/to/homer/homer.beige.v.3 -size given

