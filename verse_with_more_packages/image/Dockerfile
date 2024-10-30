FROM rocker/verse:4.3.0
LABEL org.opencontainers.image.created="2024-10-28" \
    org.opencontainers.image.authors="Lucille Delisle" \
    org.opencontainers.image.description="Docker image based on rocker:verse with more packages" \
    org.opencontainers.image.title="verse_with_more_packages" \
    org.opencontainers.image.url="https://github.com/lldelisle/lldelisle-docker/blob/main/verse_with_more_packages" \
    org.opencontainers.image.source="https://github.com/lldelisle/lldelisle-docker/blob/main/verse_with_more_packages/image/Dockerfile"
# Copy the file with the list of packages and versions
COPY helpers/packages.to.install_4.3.0_0.txt /tmp/
COPY helpers/install_packages_4.3.0_0.R /tmp/
# Add the libhdf5-dev and patch for hdf5r, libudunits2-dev for units for sf, libgdal-dev for sf,  libgsl-dev library needed for DirichletMultinomial, libboost-filesystem-dev libboost-system-dev for velocyto.R
# Add python for scvelo
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libhdf5-dev \
    libudunits2-dev \
    patch \
    libgdal-dev \
    libgsl-dev \
    libboost-filesystem-dev libboost-system-dev \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*
# Install R packages
# The .Renviron contains the GITHUB_PAT
RUN --mount=type=secret,id=renv,target=/root/.Renviron \
    Rscript /tmp/install_packages_4.3.0_0.R
# Some dependencies may need a second run
# The .Renviron contains the GITHUB_PAT
RUN --mount=type=secret,id=renv,target=/root/.Renviron \
    Rscript /tmp/install_packages_4.3.0_0.R
# Install python scvelo
RUN pip install anndata scvelo 'numpy<2' 'scipy<1.14.0'
