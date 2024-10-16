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
# Install libhdf5-dev
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libhdf5-dev \
    patch \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*
# Install packages for velocyto
RUN R -e 'BiocManager::install("pcaMethods");remotes::install_github("lldelisle/velocyto.R", ref = "comment_rf_warning", upgrade = "never")'
# Install packages to deal with loom/seurat
RUN R -e 'remotes::install_github("satijalab/seurat-wrappers", upgrade = "never");remotes::install_github("cellgeni/sceasy", upgrade = "never")'
# Install python anndata and reticulate
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*
RUN pip install anndata
RUN R -e 'install.packages("reticulate")'
# Install scvelo
RUN pip install scvelo
# Downgrade numpy to <2 to be compatible with scvelo
RUN pip install 'numpy<2'
# Downgrade scipy to <1.14.0 to be compatible with scvelo
RUN pip install 'scipy<1.14.0'
