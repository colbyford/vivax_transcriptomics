library(Rsamtools)

## List all output SAM files
sams <-  list.files("output/", full.names=TRUE, pattern="\\.sam$")

## Convert all SAM files to BAM
lapply(sams, asBam)
