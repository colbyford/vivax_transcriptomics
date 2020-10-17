library(Rhisat2)

## Building a genome index
# list.files(system.file("extdata/refs", package="Rhisat2"), pattern="\\.fa$")

# refs <- list.files(system.file("extdata/refs", package="Rhisat2"), 
#                    full.names=TRUE, pattern="\\.fa$")
# td <- tempdir()


# refs <- list.files("refs/", full.names=TRUE, pattern="\\.fasta$")
refs <- list.files("refs", full.names=TRUE, pattern="\\.fasta$")

dir <- "output"

hisat2_build(references=refs, outdir=dir, prefix="vivax_index", 
             force=TRUE, strict=TRUE, execute=TRUE)

## Aligning reads to the genome index
# list.files(system.file("extdata/reads", package="Rhisat2"), 
#            pattern="\\.fastq$")
# 
# reads <- list.files(system.file("extdata/reads", package="Rhisat2"),
#                     pattern="\\.fastq$", full.names=TRUE)

# reads <- list.files("reads/", pattern="\\.fastq$", full.names=TRUE)

# reads <- list.files("../../../Dropbox (UNC Charlotte)/ELo_vivax_transcriptomics_ethiopia/30-387789029/00_fastq", pattern="\\.fastq.gz$", full.names=TRUE)

samples <- read.table("sample_summary.txt", header = TRUE, stringsAsFactors = FALSE)

for (i in seq_along(samples$SampleID)){
  cat("Processing Sample:", samples$SampleID[i], "\n")
  # R1_read <- samples$FileR1[i]
  # R2_read <- samples$FileR2[i]
  
  # reads <- list.files("reads/", pattern="\\.fastq$", full.names=TRUE)
  
  reads <- as.list(samples[i, 2:3])
  
  
  hisat2(sequences=as.list(reads), index=file.path(dir, "vivax_index"),
         type="paired", outfile=file.path(dir, paste0(samples$SampleID[i], "_output.sam")),
         threads = parallel::detectCores()-1, force=TRUE, strict=TRUE, execute=TRUE)
  
}
  

# hisat2(sequences=as.list(reads), index=file.path(td, "vivax_index"), 
#        type="paired", outfile=file.path(td, "output.sam"), 
#        force=TRUE, strict=TRUE, execute=TRUE)


# With Splice Sites
# spsfile <- tempfile()
# gtf <- system.file("extdata/refs/genes.gtf", package="Rhisat2")
# extract_splice_sites(features=gtf, outfile=spsfile)
# 
# hisat2(sequences=as.list(reads), index=file.path(td, "myindex"),
#        type="paired", outfile=file.path(td, "out_sps.sam"),
#        `known-splicesite-infile`=spsfile, 
#        force=TRUE, strict=TRUE, execute=TRUE)
