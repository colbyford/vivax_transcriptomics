# Transcriptomics of _P. vivax_ from Ethiopia

## Process
1. Align to reference sequences (using HISAT2).
2. Remove human reads from alignment (using Samtools).
3. Map remaining reads to _P. vivax_ genome (using Rsubread) and count gene frequencies.
4. Perform deconvolution of the samples (using CIBERSORTx).
5. Compare the 43 transcript expressions (using DESeq2 or edgeR)...
    - relative to Saimiri (Duffy-negative) and Aotus monkey _P. vivax_ from Gunalan et al. (2019) paper.
    - relative to the 26 Cambodian _P. vivax_ from Kim et al. (2019) paper.

## Reference Sequences
_Plasmodium vivax_ ASM241v2 - From: https://www.ncbi.nlm.nih.gov/genome/35

| Type 	| Name 	|                              RefSeq                             	| Size (Mb) 	|  GC% 	| Proteins 	| Genes	|
|:----:	|:----:	|:---------------------------------------------------------------:	|:---------:	|:----:	|:-------:	|:----:	|
|  Chr 	|   1  	| [NC_009906.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009906.1) 	|    0.83   	| 47.1 	|   167   	|  176 	|
|  Chr 	|   2  	| [NC_009907.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009907.1) 	|    0.76   	| 44.9 	|   154   	|  162 	|
|  Chr 	|   3  	| [NC_009908.2](https://www.ncbi.nlm.nih.gov/nuccore/NC_009908.2) 	|    1.01   	| 44.9 	|   209   	|  220 	|
|  Chr 	|   4  	| [NC_009909.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009909.1) 	|    0.88   	| 45.1 	|   207   	|  208 	|
|  Chr 	|   5  	| [NC_009910.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009910.1) 	|    1.37   	| 44.3 	|   310   	|  315 	|
|  Chr 	|   6  	| [NC_009911.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009911.1) 	|    1.03   	| 45.9 	|   244   	|  248 	|
|  Chr 	|   7  	| [NC_009912.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009912.1) 	|    1.5    	| 45.6 	|   351   	|  353 	|
|  Chr 	|   8  	| [NC_009913.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009913.1) 	|    1.68   	| 45.4 	|   373   	|  379 	|
|  Chr 	|   9  	| [NC_009914.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009914.1) 	|    1.92   	| 46.1 	|   432   	|  434 	|
|  Chr 	|  10  	| [NC_009915.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009915.1) 	|    1.42   	|  45  	|   317   	|  327 	|
|  Chr 	|  11  	| [NC_009916.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009916.1) 	|    2.07   	| 45.1 	|   459   	|  468 	|
|  Chr 	|  12  	| [NC_009917.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009917.1) 	|     3     	| 44.6 	|   690   	|  695 	|
|  Chr 	|  13  	| [NC_009918.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009918.1) 	|    2.03   	| 45.7 	|   445   	|  449 	|
|  Chr 	|  14  	| [NC_009919.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009919.1) 	|    3.12   	|  43  	|   691   	|  699 	|
|      	|  MT  	| [NC_007243.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_007243.1) 	|    0.01   	| 30.5 	|    3    	|   3  	|

### Annotation
_Plasmodium vivax P01_ (Version: [2018-02-28](https://plasmodb.org/plasmo/app/record/organism/TMPTX_pvivP01#SequenceCounts)) from PlasmoDB: https://plasmodb.org/plasmo/app/downloads/Current_Release/PvivaxP01/gff/data/

## Docker

To build Docker image, navigate to the `docker` folder and run:
```
docker build -t vivax_pipeline .
```

Then run the following to access an RStudio Server:
```
docker run --name vivax_pipeline --rm -p 8787:8787 vivax_pipeline
```
