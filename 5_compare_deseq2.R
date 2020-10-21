library(DESeq2)

# https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

cts <- read.csv("output/feature_counts.csv",
                row.names="gene_id") %>%
  as.matrix()

coldata <- read.csv("refs/") 

dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ group)

dds <- DESeq(dds)
res <- results(dds)
