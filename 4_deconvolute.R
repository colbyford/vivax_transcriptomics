library(dplyr)

## Read in feature counts from previous step
feature_counts <- read.csv("output/feature_counts.csv")

## Calculate the total number of reads by sample
feature_sums <- feature_counts %>% 
  select(-gene_id) %>%
  summarise_all(funs(sum)) %>%
  t() %>% 
  as_tibble(rownames = "sample")

colnames(feature_sums) <- c("sample", "mapped_reads")

## Read in Deconvolution Proportions from CIBERSORTx
deconv_data <- read.csv("output/CIBERSORTx_Job3_Results.csv")

## Join the feature counts to the deconvolution and get estimated read counts by stage
deconv_data_counts <- feature_sums %>% 
  inner_join(deconv_data, by = c("sample" = "Mixture")) %>% 
  mutate(Rings_count = as.integer(mapped_reads * Rings),
         Trophozoites.30_count = as.integer(mapped_reads * Trophozoites.30),
         Trophozoites.36_count = as.integer(mapped_reads * Trophozoites.36),
         Schizonts_count = as.integer(mapped_reads * Schizonts))

write.csv(deconv_data_counts, "output/deconvolution_output.csv", row.names = FALSE)
