# htsstation_4cseq_standalone

This image is used to run 4C-seq analysis as it was previously done in htsstation.epfl.ch.

Here is an example of usage (all input files and configs are in [test_data/](test_data/)). This example uses mm10 as it was on htsstation.sh but you can build your own genome see [an example](https://github.com/lldelisle/scriptsForRodriguezCarballoEtAl2020/blob/master/slurm_scripts/00_makeGenomeFor4CHTS.sh).

```bash
# First define your local path
pathLocal="/home/ldelisle/Documents/sequencing/docker_4C/working4/"
# Then decide the path on docker this will be used in the config files
pathDocker="/working/"

# The docker image will use the genomes in /data/genrep and the 4C libraries in /data/4cLibraries
# Specify the path where your local data are:
pathLocalData="/home/ldelisle/Documents/sequencing/docker_4C/data/"

# Create the local path:
mkdir -p ${pathLocal}

# If you are running the test copy files from test_data to local path:
cp test_data/* ${pathLocal}

# If you want to use mm10, the genrep and 4C libraries have been put on zenodo:
mkdir -p ${pathLocalData}
# Download mm10 like in htsstation
curl -SL https://zenodo.org/record/5905346/files/minimal_HTSstation_mm10.tar?download=1 \
    | tar -xC ${pathLocalData}/

# Demultiplexing
conffile="config_demult_test.txt"
if [ ! -e ${pathLocal}/${conffile} ]; then
    echo "conffile must be in pathLocal"
    exit 1
fi
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    htsstation_4cseq_standalone \
    init_bein_minilims.py -d ${pathDocker} -m demultiplexing
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    --mount type=bind,source=${pathLocalData},target=/data \
    htsstation_4cseq_standalone \
    run_htsstation.py demultiplexing -v local -w ${pathDocker} -c ${pathDocker}/$conffile --basepath=${pathDocker} --no-email
mkdir -p ${pathLocal}/res_files
desc=$(cat ${pathLocal}/$conffile | awk -F "\047" '$1=="description="{print $2}')
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    htsstation_4cseq_standalone \
    parse_output.sh ${pathDocker}/demultiplexing_minilims ${desc} ${pathDocker}/res_files

# Mapping
conffile="config_mapseq_test.txt"
if [ ! -e ${pathLocal}/${conffile} ]; then
    echo "conffile must be in pathLocal"
    exit 1
fi
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    htsstation_4cseq_standalone \
    init_bein_minilims.py -d ${pathDocker} -m mapseq
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    --mount type=bind,source=${pathLocalData},target=/data \
    htsstation_4cseq_standalone \
    run_htsstation.py mapseq -v local -w ${pathDocker} -c ${pathDocker}/$conffile --basepath=${pathDocker} --no-email
mkdir -p ${pathLocal}/res_files_mapping_mm10
desc=$(cat ${pathLocal}/$conffile | awk -F "\047" '$1=="description="{print $2}')
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    htsstation_4cseq_standalone \
    parse_output.sh ${pathDocker}/mapseq_minilims ${desc} ${pathDocker}/res_files_mapping_mm10

# 4C-seq
conffile="config_4cseq_test.txt"
if [ ! -e ${pathLocal}/${conffile} ]; then
    echo "conffile must be in pathLocal"
    exit 1
fi
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    htsstation_4cseq_standalone \
    init_bein_minilims.py -d ${pathDocker} -m 4cseq
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    --mount type=bind,source=${pathLocalData},target=/data \
    htsstation_4cseq_standalone \
    run_htsstation.py 4cseq -v local -w ${pathDocker} -c ${pathDocker}/$conffile --basepath=${pathDocker} --no-email
mkdir -p ${pathLocal}/res_files_4Cseq
desc=$(cat ${pathLocal}/$conffile | awk -F "\047" '$1=="description="{print $2}')
docker run --rm --mount type=bind,source=${pathLocal},target=${pathDocker} \
    htsstation_4cseq_standalone \
    parse_output.sh ${pathDocker}/4cseq_minilims ${desc} ${pathDocker}/res_files_4Cseq
```
