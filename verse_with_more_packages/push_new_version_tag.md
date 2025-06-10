# How to push a new tag with a new R version or an existing R version

## How to get a new tag for an existing image

1. Modify the good docker file, for example [Dockerfile_4.4.2](./image/Dockerfile_4.4.2):
    1. For version 4.4.1: by adding lines on the bottom with the specific packages.
    1. For other verions:
        - for the CRAN/Bioconductor packages, create a file with a name like `packages.to.install_4.4.2_1.txt` containing one package name per line and add to the Dockerfile:
        ```
        COPY helpers/packages.to.install_4.4.2_1.txt /tmp/
        RUN R -e 'install.packages("BiocManager");my.packages <- read.delim("/tmp/packages.to.install_4.4.2_1.txt", header = FALSE)[, 1]; BiocManager::install(my.packages, update = FALSE, ask = FALSE)'
        ```
        - for the github packages, add to the Dockerfile something like:
        ```
        # The .Renviron contains the GITHUB_PAT
        RUN --mount=type=secret,id=renv,target=/root/.Renviron \
            R -e 'remotes::install_github("satijalab/seurat-wrappers", upgrade = "never", ref = "8d46d6c47c089e193fe5c02a8c23970715918aa9")'
        ```

        
         for version 4.4.2 and above and by installing github packages by adding them in the Dockerfile.

1. Build it using the GITHUB_PAT

```bash
cd verse_with_more_packages/image/
RVERSION=4.4.3
IMAGE_VERSION=1
docker build --secret id=renv,src=/home/delislel/.Renviron -t verse_with_more_packages:${RVERSION}_${IMAGE_VERSION} -f ./Dockerfile_${RVERSION} . &> ${RVERSION}_${IMAGE_VERSION}.log
```
If it is recreating the first layers instead of using the cache, then you need to change the docker file to start from the previous version like [this example](./image/Dockerfile_4.4.1_8).

1. Tag it for dockerhub and push

```bash
docker image tag verse_with_more_packages:${RVERSION}_${IMAGE_VERSION} lldelisle/verse_with_more_packages:${RVERSION}_${IMAGE_VERSION}
docker push lldelisle/verse_with_more_packages:${RVERSION}_${IMAGE_VERSION}
```

1. (Optional) create a singularity

```bash
singularity build verse_with_more_packages_${RVERSION}_${IMAGE_VERSION}.sif docker-daemon://verse_with_more_packages:${RVERSION}_${IMAGE_VERSION}
```

## How to create a version because there is a new version of R

1. Check that there is a dockerhub image corresponding to the new R version [here](https://hub.docker.com/r/rocker/verse/tags).

1. Create a new file in [this directory](./image/helpers/) maybe copying the last `packages.to.install_*.txt` to `packages.to.install_<r_version>_0.txt` and adding new packages (only from CRAN and Bioconductor) potentially.

1. Copy the last Dockerfile that started from verse and name it with the R version.

1. Modify the Dockerfile in [image](./image/) to fit the new version and add the new R packages from gitHub etc...

1. Build it using the GITHUB_PAT

```bash
RVERSION=4.4.3
cd verse_with_more_packages/image/
docker build --secret id=renv,src=/home/delislel/.Renviron -f Dockerfile_${RVERSION} -t verse_with_more_packages:${RVERSION}_0 . &> ${RVERSION}_0.log
```

1. Tag it for dockerhub and push

```bash
docker image tag verse_with_more_packages:${RVERSION}_0 lldelisle/verse_with_more_packages:${RVERSION}_0
docker push lldelisle/verse_with_more_packages:${RVERSION}_0
```

1. (Optional) create a singularity

```bash
singularity build verse_with_more_packages_${RVERSION}_0.sif docker-daemon://verse_with_more_packages:${RVERSION}_0
```
