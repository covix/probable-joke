#!/usr/bin/env bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

ENR_CODE=`dirname $0`  # Current folder

CMD="\
    addpath(genpath([cd '/' '$ENR_CODE'])); \
    align_deep_pca_pimw('$INPUT_FOLDER', '$OUTPUT_FOLDER', '$ENR_CODE'); \
    exit;
"

$MATLAB -nodesktop -nodisplay -nosplash -r "$CMD"
