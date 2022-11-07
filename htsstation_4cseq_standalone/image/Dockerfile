FROM ubuntu
LABEL org.opencontainers.image.created="2022-11-07" \
    org.opencontainers.image.authors="Lucille Delisle" \
    org.opencontainers.image.description="Container with all dependencies\
 to run 4C-seq analysis like in htsstation.epfl.ch" \
    org.opencontainers.image.title="HTSstation 4Cseq standalone" \
    org.opencontainers.image.url="https://github.com/lldelisle/lldelisle-docker/blob/main/htsstation_4cseq_standalone" \
    org.opencontainers.image.source="https://github.com/lldelisle/lldelisle-docker/blob/main/htsstation_4cseq_standalone/image/Dockerfile"
ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y \
bowtie \
bowtie2 \
build-essential \
bzip2 \
cpio \
curl \
exonerate \
expat \
fastqc \
gettext \
gfortran \
git \
libblas-dev \
liblapack-dev \
libncurses5-dev \
libsqlite3-dev \
libtclap-dev \
picard \
python-pip \
python2 \
python2-dev \
r-base \
r-cran-plotrix \
r-cran-rcolorbrewer \
r-cran-rjson \
rpm2cpio \
sqlite \
xz-utils \
zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/python2 /usr/bin/python
RUN pip2 install numpy
RUN pip2 install scipy
RUN pip2 install configobj
RUN pip2 install pysam
RUN mkdir -p /usr/src/ \
    && curl -SL https://jasoncantarella.com/downloads/libtsnnls-2.3.4.tar.gz \
    | tar -xzC /usr/src/ \
    && cwd=$(pwd) \
    && cd /usr/src/libtsnnls-2.3.4 \
    && ./configure --with-blas=/usr/lib/x86_64-linux-gnu/blas/libblas.so \
    && cd $cwd \
    && make -C /usr/src/libtsnnls-2.3.4 install
RUN curl http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedGraphToBigWig -o /usr/local/bin/bedGraphToBigWig \
    && chmod 755 /usr/local/bin/bedGraphToBigWig
RUN mkdir -p /usr/src/ \
    && curl -SL https://sourceforge.net/projects/samtools/files/samtools/0.1.19/samtools-0.1.19.tar.bz2 \
    | tar -xjC /usr/src/ \
    && make -C /usr/src/samtools-0.1.19 \
    && ln -snf /usr/src/samtools-0.1.19 /usr/include/samtools
RUN curl -SL https://archives.fedoraproject.org/pub/archive/epel/7/x86_64/Packages/s/samtools-libs-0.1.19-7.el7.x86_64.rpm \
    | rpm2cpio | cpio -idmv \
    && ln -snf /usr/lib64/libbam.so.1 /usr/lib64/libbam.so
RUN git -C /usr/src/ clone https://github.com/bbcf/bbcflib.git -b standalone
RUN git -C /usr/src/ clone https://github.com/bbcf/bbcfutils.git -b standalone
RUN git -C /usr/src/ clone https://github.com/bbcf/rnacounter.git
RUN git -C /usr/src/ clone https://github.com/bbcf/bsPlugins.git
RUN cwd=$(pwd) \
    && cd /usr/src/bbcflib \
    && python2 setup.py install \
    && cd $cwd
RUN cwd=$(pwd) \
    && cd /usr/src/bsPlugins \
    && python2 setup.py install \
    && cd $cwd
RUN sed -i "s/lsatlas/lblas/" /usr/src/bbcfutils/C/Makefile \
    && make -C /usr/src/bbcfutils/C/
COPY init_bein_minilims.py /usr/local/bin/init_bein_minilims.py
COPY parse_output.sh /usr/local/bin/parse_output.sh
RUN mkdir -p /data \
    && chmod 755 /usr/local/bin/init_bein_minilims.py \
    && chmod 755 /usr/local/bin/parse_output.sh
ENV PATHFORBBCFUTILS="/usr/src/"
ENV PYTHONPATH="${PATHFORBBCFUTILS}/bbcfutils/Python/:/usr/local/lib/python2.7/site-packages/:$PYTHONPATH"
ENV PATH="${PATHFORBBCFUTILS}/bbcfutils/Python/:${PATHFORBBCFUTILS}/bbcfutils/bash_scripts/:${PATHFORBBCFUTILS}/bbcfutils/C/:/usr/src/samtools-0.1.19/:/usr/local/bin/:$PATH"
ENV LD_LIBRARY_PATH="/usr/lib64:/usr/local/lib:/lib:$LD_LIBRARY_PATH"
