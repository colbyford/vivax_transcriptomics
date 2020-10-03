## Install Packages
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")

# Hisat2: https://bioconductor.org/packages/release/bioc/vignettes/Rhisat2/inst/doc/Rhisat2.html
BiocManager::install("Rhisat2")
# DESeq2: https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
BiocManager::install("DESeq2")

## Load in Packages
# library(dplyr)
# library(Rhisat2)
# library(DESeq2)

source("1_align_hisat.R")
source("2_map.R")
source("3_comparison_deseq2.R")




