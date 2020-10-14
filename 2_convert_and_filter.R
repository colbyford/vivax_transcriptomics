library(Rsamtools)
library(stringr)

## List all output SAM files
sam_files <- list.files("output/", full.names=TRUE, pattern="\\.sam$")

## Convert all SAM files to BAM
cat("Converting", length(sam_files), "SAM files to BAM.\n")

lapply(sam_files, asBam)
# asBam(sam_files[2])


## List all output BAM files
bam_files <- list.files("output/", full.names=TRUE, pattern="\\.bam$")

# bams <- BamFileList(bam_files)
# seqinfo(bams)


## Filter down to only P. vivax reads (MAPQ > 20)
filter <- FilterRules(list(MinQuality = function(x) x$mapq > 20))
# filterBam(bam_files[1], destination = "GHC-017_output_filtered.bam", filter = filter)

for (i in seq_along(bam_files)){
  cat("Processing BAM file:", bam_files[i], "\n")
  
  bam_iter <- bam_files[i]
  
  filterBam(bam_iter,
            destination = paste0(str_remove(bam_iter, ".bam"), "_filtered.bam"),
            filter = filter)
  
}
