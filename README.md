# Transcriptomics of _P. vivax_ from Ethiopia

## Process
1. Align to and remove human reads (using HISAT2).
2. Map remaining reads to _P. vivax_ genome.
3. Compare the 43 transcript expressions relative to Saimiri (Duffy-negative) and Aotus monkey _P. vivax_ from Gunalan et al. (2019) paper (using DESeq2 or edgeR).
4. Compare the 43 transcript expressions relative to the 26 Cambodian _P. vivax_ from Kim et al. (2019) paper.


## Docker

To build Docker image, navigate to the `docker` folder and run:
```
docker build -t vivax_pipeline .
```

Then run the following to access an RStudio Server:
```
docker run --name vivax_pipeline --rm -p 8787:8787 vivax_pipeline
```
