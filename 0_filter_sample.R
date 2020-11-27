#!/usr/bin/env Rscript

library(cytosieve)
library(Biostrings)
library(dplyr)
library(stringr)

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("\t1st arg must be the sample name.\n\t2nd arg must be number of genes by which to filter.\n", call.=FALSE)
} else if (length(args)==1) {
  # default to only the first gene
  args[2] = 1
  cat("Using sample name:", args[1],"\tFiltering using:", args[2], "gene(s).\n")
} else if (length(args)==2) {
  cat("Using sample name:", args[1],"\tFiltering using:", args[2], "gene(s).\n")
} else {
  warning("Too many arguments. Only the first 2 will be used.\n")
}

## Filter out reads that have genes that are not expressed in a particular stage/cell type of interest
samples <- read.table("sample_summary.txt", header = TRUE, stringsAsFactors = FALSE)

sample <- which(samples$SampleID %in% as.character(args[1]))
# sample <- which(samples$SampleID %in% "GHC-006")

## Genes that are NOT expressed in Schizonts
# genes <- readDNAStringSet("refs/schizont_filter_all29.fasta")[1:as.numeric(args[2])]
genes <- readDNAStringSet("refs/PVP01_Genes_Schizont_gt1_concatenated.fasta")

input_R1_fastq_path <- samples$FileR1[sample]
output_R1_fastq_path <- paste0(str_remove(input_R1_fastq_path, ".fastq"), "_filtered_", args[2], ".fastq")
input_R2_fastq_path <- samples$FileR2[sample]
output_R2_fastq_path <- paste0(str_remove(input_R2_fastq_path, ".fastq"), "_filtered_", args[2], ".fastq")

cat("Now reading sample:", samples$SampleID[sample],"\n")

## Filter out reads from the input R1 (and R2) sample files
## Filter out reads from the input R1 (and R2) sample files
filter_reads(input_path = input_R1_fastq_path,
             output_path = output_R1_fastq_path,
             genes_to_find = genes,                 # Genes that do not occur in the desired cell type
             # eliminate_matches = TRUE,              # Remove genes that match from the exclusion list
             eliminate_matches = FALSE,             # Only keep genes that match
             pct_variability = 0.10,
             paired = TRUE,
             input_r2_path = input_R2_fastq_path,
             output_r2_path = output_R2_fastq_path,
             par_method = "foreach",
             verbose = FALSE)


