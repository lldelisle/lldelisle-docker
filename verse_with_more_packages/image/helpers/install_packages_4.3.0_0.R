options(
    repos = c(getOption("repos"), "CRAN" = "https://cran.r-project.org", "Bioconductor" = "https://bioconductor.org/packages/3.17/bioc"),
    timeout = 300
)
df <- read.delim("/tmp/packages.to.install_4.3.0_0.txt")
cran.bioc.df <- subset(df, origin %in% c("Bioconductor", "CRAN"))
for (i in seq_len(nrow(cran.bioc.df))) {
    my.package <- cran.bioc.df[i, "Package"]
    my.version <- cran.bioc.df[i, "toInstall"]
    if (!my.package %in% installed.packages() | !my.version %in% installed.packages()[installed.packages()[, "Package"] == my.package, "Version"]) {
        print(paste("Installing ", my.package, my.version))
        # First try install_version or Archive of bioconductor
        tryCatch(
            devtools::install_version(my.package, my.version, upgrade = "never"),
            error = function(e) {
                install.packages(paste0("https://mghp.osn.xsede.org/bir190004-bucket01/archive.bioconductor.org%2Fpackages%2F3.17%2Fbioc%2Fsrc%2Fcontrib%2FArchive%2F", my.package, "%2F", my.package, "_", my.version, ".tar.gz"))
            }
        )
        # Then try db bioconductor
        if (!my.package %in% installed.packages()) {
            tryCatch(install.packages(paste0("https://bioconductor.org/packages/3.17/data/annotation/src/contrib/", my.package, "_", my.version, ".tar.gz")))
        }
    }
    # Sometimes it fails for unknown reason so we test a second time
    if (!my.package %in% installed.packages() | !my.version %in% installed.packages()[installed.packages()[, "Package"] == my.package, "Version"]) {
        print(paste("Second try for ", my.package, my.version))
        tryCatch(
            devtools::install_version(my.package, my.version, upgrade = "never"),
            error = function(e) {
                install.packages(paste0("https://mghp.osn.xsede.org/bir190004-bucket01/archive.bioconductor.org%2Fpackages%2F3.17%2Fbioc%2Fsrc%2Fcontrib%2FArchive%2F", my.package, "%2F", my.package, "_", my.version, ".tar.gz"))
            }
        )
    }
    # Some packages have been installed with version 3.18
    # This is bad but to reproduce the environment...
    if (!my.package %in% installed.packages() | !my.version %in% installed.packages()[installed.packages()[, "Package"] == my.package, "Version"]) {
        print(paste("Try Bioconductor 3.18 for ", my.package, my.version))
        tryCatch(
            devtools::install_version(my.package, my.version, upgrade = "never", repos = "https://bioconductor.org/packages/3.18/bioc"),
            error = function(e) {
                install.packages(paste0("https://mghp.osn.xsede.org/bir190004-bucket01/archive.bioconductor.org%2Fpackages%2F3.18%2Fbioc%2Fsrc%2Fcontrib%2FArchive%2F", my.package, "%2F", my.package, "_", my.version, ".tar.gz"))
            }
        )
    }
}

# Install github packages:
# No way to know the version of this package...
if (!"pochi" %in% installed.packages()) {
    remotes::install_github("diegoalexespi/pochi", upgrade = "never")
}
install.packages("https://cran.r-project.org/src/contrib/Archive/rgeos/rgeos_0.6-2.tar.gz")
if (!"SeuratWrappers" %in% installed.packages()) {
    remotes::install_github("satijalab/seurat-wrappers", upgrade = "never", ref = "d28512f804d5fe05e6d68900ca9221020d52cf1d")
}
if (!"SeuratDisk" %in% installed.packages()) {
    remotes::install_github("mojaveazure/seurat-disk", upgrade = "never", ref = "877d4e18ab38c686f5db54f8cd290274ccdbe295")
}
if (!"usefulLDfunctions" %in% installed.packages()) {
    remotes::install_github("lldelisle/usefulLDfunctions", upgrade = "never", ref = "v0.1.6")
}
if (!"velocyto.R" %in% installed.packages()) {
    remotes::install_github("velocyto-team/velocyto.R", upgrade = "never", ref = "0.6")
}

for (i in seq_len(nrow(df))) {
    my.package <- df[i, "Package"]
    my.version <- df[i, "toInstall"]
    if (!my.package %in% installed.packages()) {
        print(paste(my.package, "is not installed"))
    } else if (!my.version %in% installed.packages()[installed.packages()[, "Package"] == my.package, "Version"]) {
        print(paste(my.package, "is installed with different version"))
    }
}

# [1] "spatstat.univar is installed with different version"
