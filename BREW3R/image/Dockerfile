FROM ubuntu
LABEL org.opencontainers.image.created="2024-05-28" \
    org.opencontainers.image.authors="Lucille Delisle" \
    org.opencontainers.image.description="Container with all dependencies to run BREW3R" \
    org.opencontainers.image.title="BREW3R" \
    org.opencontainers.image.url="https://github.com/lldelisle/lldelisle-docker/blob/main/BREW3R" \
    org.opencontainers.image.source="https://github.com/lldelisle/lldelisle-docker/blob/main/BREW3R/image/Dockerfile"
ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y \
stringtie \
wget \
software-properties-common
# Add the CRAN repository
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu noble-cran40/"
# Install R dependencies
RUN apt-get install -y libcurl4-openssl-dev \
libfontconfig1-dev \
libcairo2-dev \
libssl-dev \
libxml2-dev
# Install R
RUN apt-get install -y r-base && rm -rf /var/lib/apt/lists/*
# Install the BREW3R.r package
RUN R -e 'if (!require("BiocManager", quietly = TRUE)){install.packages("BiocManager")};BiocManager::install("BREW3R.r")'
# Install the rtracklayer package needed to import gtf
RUN R -e 'BiocManager::install("rtracklayer")'
# Install the getopt package
RUN R -e 'install.packages("getopt")'
