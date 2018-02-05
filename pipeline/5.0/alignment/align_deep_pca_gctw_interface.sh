#!/usr/bin/env bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

MATLAB=/usr/local/bin/matlab2017a

echo "Alert: aligning only one class"
for i in {01..01};
do

    ENR_CODE=`dirname $0`  # Current folder
    echo $ENR_CODE

    CMD="\
        addpath(genpath(['$ENR_CODE'])); \
        align_deep_pca_gctw_class('${INPUT_FOLDER}/${i}', '$i', '$OUTPUT_FOLDER', '$ENR_CODE'); \
        exit;
    "

    $MATLAB -r "$CMD" # > gctw.log 2>&1

done



addpath(genpath([cd '/' '/data/sparks/share/asl/probable-joke/pipeline/5.0/alignment']));
