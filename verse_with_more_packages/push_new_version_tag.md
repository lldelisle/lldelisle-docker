# How to push a new version or a new tag

## How to get a new tag for an existing image

1. Find the commit corresponding to the last version of the image
1. Restore the Dockerfile to this version with

```bash
git restore -s <commit_hash> verse_with_more_packages/image/Dockerfile
```

1. Modify the [Dockerfile](./image/Dockerfile) by adding lines on the bottom.
1. Build it

```bash
cd verse_with_more_packages/image/
docker build -t verse_with_more_packages_<version>:<tag> .
```
If it is recreating the first layers instead of using the cache, then you need to change the docker file to start from the previous version see [this example](https://github.com/lldelisle/lldelisle-docker/blob/d542cdc/verse_with_more_packages/image/Dockerfile).

1. Tag it for dockerhub and push

```bash
docker image tag verse_with_more_packages_<version>:<tag> lldelisle/verse_with_more_packages_<version>:<tag>
```

## How to create a version because there is a new version of R

1. Check that there is a dockerhub image corresponding to the new R version [here](https://hub.docker.com/r/rocker/verse/tags).

1. Create a new file in [this directory](./image/helpers/) maybe copying the last `packages.to.install_<version>.txt` and adding new packages (only from CRAN and Bioconductor) potentially.

1. Restore the Docker file to the last version with the `_0`, for example:

```bash
git restore -s f9e438a3cc155229b6e6a494292634d08bf20c30 verse_with_more_packages/image/Dockerfile
```

1. Modify the [Dockerfile](./image/Dockerfile) to fit the new version and add the new R packages from gitHub etc...

1. Build it using the GITHUB_PAT

```bash
cd verse_with_more_packages/image/
docker build --secret id=renv,src=/home/ldelisle/.Renviron -t verse_with_more_packages_<version>:<tag> . &> <version>_<tag>.log
```

1. Tag it for dockerhub and push

```bash
docker image tag verse_with_more_packages_<version>:<tag> lldelisle/verse_with_more_packages_<version>:<tag>
```
