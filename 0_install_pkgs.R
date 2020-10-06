## Install Packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Hisat2: https://bioconductor.org/packages/release/bioc/vignettes/Rhisat2/inst/doc/Rhisat2.html
# devtools::install_github("fmicompbio/Rhisat2")
BiocManager::install("Rhisat2")
# DESeq2: https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
# devtools::install_github("mikelove/DESeq2")
BiocManager::install("DESeq2")
