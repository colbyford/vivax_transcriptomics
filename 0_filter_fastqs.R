library(ShortRead)
library(Biostrings)
library(dplyr)
library(stringr)


## Filter out reads that have genes that are not expressed in a particular stage/cell type of interest
samples <- read.table("sample_summary.txt", header = TRUE)

## Genes that are NOT expressed in Schizonts
# genes_to_find <- readFasta("refs/schizont_filter_ex2.fasta") 
genes_to_find <- readDNAStringSet("refs/schizont_filter_all29.fasta")


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
  
  fastq_orig <- readFastq(input_R1_fastq_path)
  
  
  # gene_iter <- genes_to_find$PVP01_0109100 %>% as.character()
  # pct_variability <- 0.05
  # mismatch_threshold <- (nchar(gene_iter) * pct_variability) %>% as.integer()
  
  # gene_iter <- "NGGAAGTTTCCAGAGATGGATGCGTGCTCGAAAGGGAACCTGCACACATGTGCTGCATGGCTGTCGTCAGCTCGTGTCGTGAGATGTTGGGTTAAGTGCCGCAACGAGCGCAACCCTTGTCATTAGTTGCTACATTCAGTTGAGCACTCT"
  pct_variability <- 0.10
  # mismatch_threshold <- (mean(fastq_orig@sread@ranges@width) * pct_variability) %>% as.integer()
  
  
  ## Intialize list for which reads to keep (FALSEs) or remove (TRUEs)
  # match_list <- c(rep(FALSE, length(fastq_orig)))
  

  ## Cluster Setup
  # library(doParallel)
  # library(foreach)
  # cl <- makeCluster(parallel::detectCores()-1, outfile = "read_filtering.log")
  # registerDoParallel(cl)
  # clusterExport(cl, c("matchPattern", "%>%"), envir=environment())
  
  ## Find the read segment in the reference gene
  search_read <- function(x, pct_variability = 0.10){
    cat("\tSearching for matches in read: ", x, "\n")
    
    read <- fastq_orig@sread[x] %>% as.character()
    
    mismatch_threshold <- (nchar(read) * pct_variability) %>% as.integer()
    
    read_matches <- Biostrings::matchPattern(read,
                                             gene %>% 
                                               Biostrings::DNAString(),
                                             with.indels=TRUE,
                                             max.mismatch = mismatch_threshold)
    
    if (length(read_matches) > 0){
      cat("\t[Found a match!]\n")
      # match_list[x] = TRUE
      return(TRUE)
    } else {
      return(FALSE)
    }
    
    rm(read_matches)
  }
  
  
  for (g in seq_along(genes_to_find)){
    gene <- genes_to_find[g] %>% as.character()
    
    cat("Current filter gene: ", names(gene), "\n")
    
    # match_list <- foreach(i = 1:100, .combine = "c", .verbose = TRUE) %dopar% 
    #   search_read(i, gene, pct_variability)
    # foreach(i = seq_along(fastq_orig@sread), .verbose = TRUE) %do% 
    #   search_read(i, gene, pct_variability)
    # foreach(i = seq_along(fastq_orig@sread), .verbose = TRUE) %dopar% 
    #   search_read(i, gene, pct_variability)
    
    match_list <- mclapply(seq_along(fastq_orig@sread),
                           search_read,
                           mc.cores = if (.Platform$OS.type == "windows"){
                             1
                           } else {
                             parallel::detectCores()-1
                           })  %>% unlist()
  }
  
  ## Fix any skipped reads at the end
  
  length(match_list) <- length(fastq_orig)
  
  
  # stopCluster(cl)
  
  
  # for (g in seq_along(genes_to_find)){
  #   gene_iter <- genes_to_find[g] %>% as.character()
  # 
  #   cat("Current filter gene: ", names(gene_iter), "\n")
  #   
  #   for (i in seq_along(fastq_orig@sread)){
  #     
  #     cat("\tSearching for matches in read: ", i, "\n")
  #     
  #     matches <- matchPattern(fastq_orig@sread[i] %>%
  #                               as.character(),
  #                             gene_iter %>% 
  #                               Biostrings::DNAString(),
  #                             with.indels=TRUE,
  #                             max.mismatch = mismatch_threshold)
  #     
  #     if (length(matches) > 0){
  #       match_list[i] = TRUE
  #     }
  #   }
  # }
  
  
  # which(match_list)
  
  ## Function to filter out these matching reads
  fun <- function(x) {
    x[-match_list]    
  }
  
  ## Filter R1 and R2 FAST
  filterFastq(input_R1_fastq_path, output_R1_fastq_path, filter=fun)
  
  filterFastq(input_R2_fastq_path, output_R2_fastq_path, filter=fun)
}



