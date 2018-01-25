#!/usr/bin/env bash

INPUT_FOLDER=$1
TEST_SAMPLE=$2
OUTPUT_FOLDER=$3

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

${ENR_CODE}/align_deep_pca_gctw_interface.sh $INPUT_FOLDER $TEST_SAMPLE $OUTPUT_FOLDER
