#!/usr/bin/env bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

MATLAB=/usr/local/bin/matlab2017a

for i in {01..43};
do

    ENR_CODE=`dirname $0`  # Current folder

    CMD="\
        addpath(genpath([$ENR_CODE'])); \
        align_deep_pca_gctw_class('${INPUT_FOLDER}/${i}', '$i', '$OUTPUT_FOLDER', '$ENR_CODE'); \
        exit;
    "

    $MATLAB -r "$CMD" # > gctw.log 2>&1

done
