# get the common peaks in at least two samples for each group

cd /path/to/nonblacklist/
multiIntersectBed -header -i *cre01* *cre02* *cre03* > /path/to/nonblacklist/common_cre
multiIntersectBed -header -i *lox01* *lox02* *lox03*  > /path/to/nonblacklist/common_lox

# then run R script (7_common_peaks_R.R) to isolate the peaks in at least two samples for each group. 
