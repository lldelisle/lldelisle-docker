FROM rocker/verse:4.4.1
LABEL org.opencontainers.image.created="2024-10-15" \
    org.opencontainers.image.authors="Lucille Delisle" \
    org.opencontainers.image.description="Docker image based on rocker:verse with more packages" \
    org.opencontainers.image.title="verse_with_more_packages" \
    org.opencontainers.image.url="https://github.com/lldelisle/lldelisle-docker/blob/main/verse_with_more_packages" \
    org.opencontainers.image.source="https://github.com/lldelisle/lldelisle-docker/blob/main/verse_with_more_packages/image/Dockerfile"
# Add the libgsl-dev library needed for DirichletMultinomial
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*
# Install some CRAN packages
RUN R -e 'install.packages(c("Seurat", "BiocManager"))'
# Install other packages
RUN R -e 'BiocManager::install(c("rtracklayer", "biovizBase", "Rsamtools", "BSgenome", "ggplot2", "stringr", "glmGamPoi", "TFBSTools", "motifmatchr", "JASPAR2022", "chromVAR", "Signac"))'
# Install usefulLDfunctions
RUN R -e 'devtools::install_github("lldelisle/usefulLDfunctions")'
