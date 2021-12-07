## Generate Plots for Gametocyte Gene Counts

library(dplyr)
library(tidyr)
library(readxl)
library(ggplot2)
library(ggbeeswarm)
library(ggrepel)

counts <- read_xlsx("../output/GametocyteGene_Counts.xlsx")

counts_pvt <- counts %>% select(!Description) %>% 
  pivot_longer(!`Gene ID`, names_to = "SampleID", values_to = "Count") %>% 
  filter(`Gene ID` %in% c("PVP01_0616100", "PVP01_1119500", "PVP01_0904300")) %>% 
  filter(!`SampleID` %in% c("GHC.006", "GHC.022"))


ggplot(data = counts_pvt, aes(x=`Gene ID`, y=Count)) + 
  geom_beeswarm(data=counts_pvt, aes(x=`Gene ID`, y=Count, color=SampleID), size = 3) +
  # geom_dotplot(binaxis='y', stackdir='center', dotsize=1) +
  geom_boxplot(alpha = 0.5) +
  xlab("Gene ID") +
  ylab("Count")


## Wilcox Test

pairwise.wilcox.test(counts_pvt$Count, counts_pvt$`Gene ID`, p.adjust.method="bonferroni")
