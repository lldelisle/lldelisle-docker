# Matrix.utils has been deprecated visiting https://CRAN.R-project.org/package=Matrix.utils
# Package ‘Matrix.utils’ was removed from the CRAN repository.
# Formerly available versions can be obtained from the archive.
# Archived on 2022-10-09 as issues were not corrected despite reminders.

url <- "https://cran.r-project.org/src/contrib/Archive/Matrix.utils/Matrix.utils_0.9.8.tar.gz"
pkgFile <- "Matrix.utils_0.9.8.tar.gz"
tmp.dir <- tempdir()
download.file(url = url, destfile = file.path(tmp.dir, pkgFile))

# Install package
install.packages(pkgs=file.path(tmp.dir, pkgFile), type="source", repos=NULL)
# Install other dependencies
install.packages("plot3D")
install.packages("rlist")
# Install RePACT
devtools::install_github("chenweng1991/RePACT", upgrade = "never", ref = "c63a48c679bb86c78b90860ee0df9e51f9c41b50")
