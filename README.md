# Transcriptomics of _P. vivax_ from Ethiopia

## Process
1. Align to and remove human reads (using HISAT2).
2. Map remaining reads map to _P. vivax_ genome.
3. Compare the 43 transcript expressions relative to Saimiri (Duffy-negative) and Aotus monkey _P. vivax_ from Gunalan et al. (2019) paper (using DESeq2 or edgeR).
4. Compare the 43 transcript expressions relative to the 26 Cambodian _P. vivax_ from Kim et al. (2019) paper.