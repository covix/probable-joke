#!/usr/bin/env bash

DATA_FOLDER=$1
OUTPUT_FOLDER=$2

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

# exit form the script on failure
set -e

# source variable files
source ./config.sh

# show loaded variables
echo "Loaded configuration:"
echo -e "\tMATLAB="$MATLAB


# First step reads from $DATA_FOLDER,
# then starts writing in $OUTPUT_FOLDER

mkdir -p ${OUTPUT_FOLDER}

# TODO add steps

# at some point...
# alignment with pimw
if [[ ! -d ${OUTPUT_FOLDER}/aligned_indexes ]];  # check if the folder already exists, if so pass to the next step
then
    mkdir ${OUTPUT_FOLDER}/aligned_indexes/
    ${ENR_CODE}/alignment/run_align_deep_pca_pimw.sh ${OUTPUT_FOLDER}/pca_10_features/ ${OUTPUT_FOLDER}/aligned_indexes/
fi;


# Usage example (covix):
# ./run_pipeline.sh ../../pipeline_data/deep_features_googlenet/ ../../pipeline_experiments/dry_run
