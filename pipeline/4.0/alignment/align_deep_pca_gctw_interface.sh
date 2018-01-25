#!/usr/bin/env bash

INPUT_FOLDER=$1
TEST_SAMPLE=$2
OUTPUT_FOLDER=$3

for i in {01..43};
do

    ENR_CODE=`dirname $0`  # Current folder

    CMD="\
        addpath(genpath([cd '/' '$ENR_CODE'])); \
        align_deep_pca_gctw_class_test('${INPUT_FOLDER}/${i}', '$i', '$TEST_SAMPLE', '$OUTPUT_FOLDER', '$ENR_CODE'); \
        exit;
    "

    $MATLAB -r "$CMD" # > gctw.log 2>&1

done
