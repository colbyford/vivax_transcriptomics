## Install Packages
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")

# Hisat2: https://bioconductor.org/packages/release/bioc/vignettes/Rhisat2/inst/doc/Rhisat2.html
BiocManager::install("Rhisat2")
# DESeq2: https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
BiocManager::install("DESeq2")

## Load in Packages
library(dplyr)
library(Rhisat2)
library(DESeq2)


## Building a genome index
list.files(system.file("extdata/refs", package="Rhisat2"), pattern="\\.fa$")

refs <- list.files(system.file("extdata/refs", package="Rhisat2"), 
                   full.names=TRUE, pattern="\\.fa$")
td <- tempdir()
hisat2_build(references=refs, outdir=td, prefix="myindex", 
             force=TRUE, strict=TRUE, execute=TRUE)

## Aligning reads to the genome index
list.files(system.file("extdata/reads", package="Rhisat2"), 
           pattern="\\.fastq$")

reads <- list.files(system.file("extdata/reads", package="Rhisat2"),
                    pattern="\\.fastq$", full.names=TRUE)

hisat2(sequences=as.list(reads), index=file.path(td, "myindex"), 
       type="paired", outfile=file.path(td, "out.sam"), 
       force=TRUE, strict=TRUE, execute=TRUE)

# With Splice Sites
# spsfile <- tempfile()
# gtf <- system.file("extdata/refs/genes.gtf", package="Rhisat2")
# extract_splice_sites(features=gtf, outfile=spsfile)
# 
# hisat2(sequences=as.list(reads), index=file.path(td, "myindex"),
#        type="paired", outfile=file.path(td, "out_sps.sam"),
#        `known-splicesite-infile`=spsfile, 
#        force=TRUE, strict=TRUE, execute=TRUE)
