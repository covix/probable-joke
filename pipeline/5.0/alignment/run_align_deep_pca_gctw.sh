#!/usr/bin/env bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

for i in {01..43};
do
    oarsub -l /core=1 -S  "${ENR_CODE}/align_deep_pca_gctw_interface.sh $INPUT_FOLDER $OUTPUT_FOLDER $i"
done


# Usage example (covix):
# ./run_align_deep_pca_gctw.sh ../../../pipeline_data/dry_run/pca_10_features/ ../../../pipeline_data/dry_run/aligned_indexes/
