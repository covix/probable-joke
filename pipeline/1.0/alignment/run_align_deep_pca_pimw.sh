#!/usr/bin/env bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

${ENR_CODE}/align_deep_pca_pimw_interface.sh $INPUT_FOLDER $OUTPUT_FOLDER

# Usage example (covix):
# ./run_align_deep_pca_pimw.sh ../../../pipeline_data/dry_run/pca_10_features/ ../../../pipeline_data/dry_run/aligned_indexes/
