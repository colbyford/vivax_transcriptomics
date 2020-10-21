library(DESeq2)
library(pheatmap)

# https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

## Perform Differential Expression Analysis
cts <- read.csv("output/feature_counts.csv",
                row.names="gene_id") %>%
  as.matrix()

coldata <- read.csv("refs/sample_groups.csv") %>%
  filter(sample %in% colnames(cts))

dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ group)

dds <- DESeq(dds)
res <- results(dds)


## Make Gene Heatmap

resSort <- res[order(res$padj),]
rld <- rlog(dds, blind=FALSE)

topgenes <- head(rownames(resSort), 10)
mat <- assay(rld)[topgenes,]
mat <- mat - rowMeans(mat)
df <- as.data.frame(colData(dds)[,c("group")])

# pheatmap(mat, annotation_col = df)

p <- pheatmap(mat, annotation_col = as.data.frame(colData(dds)))
