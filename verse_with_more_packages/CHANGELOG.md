# [4.3.0_0] 2024-10-28

Based on rocker/verse:4.3.0.

This is a copy of what is on the UPDUB rstudio server but it is a mix of things, I would not use it except to be able to reproduce an analysis.

Most of bioconductor packages are from release 3.17 except:

- S4Arrays 1.2.1
- MatrixGenerics 1.14.0
- SparseArray 1.2.4
- DelayedArray 0.28.0
- sparseMatrixStats 1.14.0
- DelayedMatrixStats 1.24.0
- beachmat 2.18.1
- BiocNeighbors 1.20.2
- BiocSingular 1.18.0
- Rhdf5lib 1.24.2
- rhdf5filters 1.14.1
- rhdf5 2.46.1
- HDF5Array 1.30.1
- ResidualMatrix 1.12.0
- scuttle 1.12.0
- batchelor 1.18.1
- limma 3.58.1
- DWLS 0.1.0

# [4.4.1_0] 2024-10-15

Based on rocker/verse:4.4.1

- Seurat 5.1.0
- Signac 1.14.0
- rtracklayer 1.64.0
- Rsamtools 2.20.0
- chromVAR 1.20.0
- ggplot2 3.5.1

# [4.4.1_1] 2024-10-16

On top:

- Add usefulLDfunctions 0.1.6

# [4.4.1_2] 2024-10-16

On top:

- Install libhdf5-dev, patch and libboost-all-dev
- Install velocyto.R version 0.6 but from lldelisle/velocyto.R branch comment_rf_warning
- Install SeuratWrappers version 0.3.5
- Install sceasy version 0.0.7

And

- Install python 3.10.12 and pip
- Install anndata version 0.10.9
- h5py 3.12.1
- numpy 2.1.2
- scipy 1.14.1

# [4.4.1_3] 2024-10-16 - DO NOT USE

On top:

- Install scvelo version 0.3.2
- loompy 3.0.7
- scikit-learn 1.5.2
- matplotlib 3.9.2
- umap_learn 0.5.6
- scanpy 1.10.3

And

- downgrade numpy to 2.0.2

# [4.4.1_4] 2024-10-16 - DO NOT USE
- downgrade numpy to 1.26.4

# [4.4.1_5] 2024-10-17
- downgrade scipy to 1.13.1

# [4.4.1_6] 2024-10-17
- install scCustomize 2.1.2
- install ggpubr 0.6.0
- install presto 1.0.0

# [4.4.1_7] 2024-10-25
- install ggseqlogo 0.2
- install demuxmix 1.6.0
- install SeuratDisk 0.0.0.9021

# [4.4.2_0] 2024-11-05

Based on rocker/verse:4.4.2

scvelo (version 0.3.2) has been installed in a virtual environment available at `/root/venv/`.

All R packages listed in [this file](./image/helpers/packages.to.install_4.4.2_0.txt) have been installed. Here are the version of some packages:

- biomaRt 2.62.0
- chromVAR 1.28.0
- ComplexHeatmap 2.22.0
- demuxmix 1.8.0
- DESeq2 1.46.0
- GenomicRanges 1.58.0
- ggh4x 0.2.8
- ggplot2 3.5.1
- ggpubr 0.6.0
- ggseqlogo 0.2
- goseq 1.58.0
- pheatmap 1.0.12
- presto 1.0.0
- Rsamtools 2.22.0
- rtracklayer 1.66.0
- scCustomize 2.1.2
- Seurat 5.1.0
- Signac 1.14.0
- TFBSTools 1.44.0
- usefulLDfunctions 0.1.6
