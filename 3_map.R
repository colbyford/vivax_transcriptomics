library(Rsubread)

## List all output filtered BAM files
bam_files <- list.files("output/", full.names=TRUE, pattern="\\_filtered.bam$")

feature_counts_iter <- featureCounts(bam_files,
                                     annot.ext="refs/PlasmoDB-48_PvivaxP01.gff",
                                     GTF.attrType = "ID",
                                     GTF.featureType = "gene",
                                     chrAliases = "refs/chr_aliases.csv",
                                     isPairedEnd = TRUE,
                                     isGTFAnnotationFile = TRUE,
                                     verbose = TRUE)

feature_counts_df <- feature_counts_iter$counts %>%
  # t() %>% 
  as.data.frame()

# propmapped(bam_files)
