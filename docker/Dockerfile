FROM rocker/verse
# FROM rocker/rstudio:3.5.3

MAINTAINER Colby T. Ford <colby.ford@uncc.edu>

ENV DISABLE_AUTH=true

## Install zlib library
RUN \
  apt-get update && \
  apt-get install -y zlib1g-dev
  
## Install R packages from CRAN
# RUN R -e "install.packages('git2r', dependencies = TRUE, repos = 'http://cran.rstudio.com/')"
# RUN R -e "install.packages('remotes', dependencies = FALSE, repos = 'http://cran.rstudio.com/')"

## Install packages
#RUN mkdir -p /tmp
#COPY 0_install_pkgs.R /tmp/0_install_pkgs.R
#RUN Rscript /tmp/0_install_pkgs.R

RUN R -e "install.packages('BiocManager', repos = 'http://cran.us.r-project.org')"
RUN R -e "BiocManager::install('Rhisat2')"
RUN R -e "BiocManager::install('Rsamtools')"
RUN R -e "BiocManager::install('Rsubread')"
RUN R -e "BiocManager::install('DESeq2')"


EXPOSE 8787