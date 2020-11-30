library(cytosieve)
library(Biostrings)
library(dplyr)
library(stringr)


## Filter out reads that have genes that are not expressed in a particular stage/cell type of interest
samples <- read.table("sample_summary.txt", header = TRUE, stringsAsFactors = FALSE)

## Genes that are NOT expressed in Schizonts
# genes_to_find <- readFasta("refs/schizont_filter_ex2.fasta") 
genes <- readDNAStringSet("refs/schizont_filter_all29.fasta")


## Loop Through Each Sample and Generate Filtered Version
for (sample in 1:nrow(samples)){
  
  input_R1_fastq_path <- samples$FileR1[sample]
  output_R1_fastq_path <- paste0(str_remove(input_R1_fastq_path, ".fastq"), "_filtered.fastq")
  input_R2_fastq_path <- samples$FileR2[sample]
  output_R2_fastq_path <- paste0(str_remove(input_R2_fastq_path, ".fastq"), "_filtered.fastq")
  
    # input_R1_fastq_path <- "reads/GHC-022_R1_001.fastq"
  # output_R1_fastq_path <- paste0(str_remove(input_R1_fastq_path, ".fastq"), "_filtered.fastq")
  # input_R2_fastq_path <- str_replace(input_R1_fastq_path, "_R1_", "_R2_")
  # output_R2_fastq_path <- paste0(str_remove(input_R2_fastq_path, ".fastq"), "_filtered.fastq")
  
  cat("Now reading sample:", samples$SampleID[sample],"\n")
  
  ## Filter out reads from the input R1 (and R2) sample files
  filter_reads(input_path = input_R1_fastq_path,
               output_path = output_R1_fastq_path,
               genes_to_find = genes,                 # Genes that do not occur in the desired cell type
               eliminate_matches = TRUE,              # Remove genes that match from the exclusion list
               pct_variability = 0.10,
               paired = TRUE,
               input_r2_path = input_R2_fastq_path,
               output_r2_path = output_R2_fastq_path,
               verbose = FALSE)
  
}



