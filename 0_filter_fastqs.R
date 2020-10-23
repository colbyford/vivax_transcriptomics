library(ShortRead)
library(Biostrings)

fastq_orig <- readFastq("reads/GHC-022_R1_001.fastq")

# genes_to_find <- readFasta("refs/schizont_filter_ex2.fasta") 
genes_to_find <- readDNAStringSet("refs/schizont_filter_ex2.fasta")# %>% PDict(algorithm = "Twobit")

vmatchPattern(genes_to_find$PVP01_0109100 %>%
                as.character(),
              fastq_orig,
              max.mismatch=5)

# awhichPDict(pdict,
#            subject,
#            max.mismatch=5,
#            min.mismatch=0,
#            with.indels=FALSE,
#            fixed=TRUE,
#            algorithm="auto",
#            verbose=FALSE)

## filter reads to keep those with GC < 0.7
fun <- function(x) {
  gc <- alphabetFrequency(sread(x), baseOnly=TRUE)[,c("G", "C")]
  x[rowSums(gc) / width(x) < .7]    
}
filterFastq(fl, tempfile(), filter=fun)