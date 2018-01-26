#!/usr/bin/env bash

INPUT_FOLDER=$1
CLASS=$2
TEST_SAMPLE=$3
OUTPUT_FOLDER=$4

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

source ${ENR_CODE}/../config.sh

oarsub -l /core=1 -S "${ENR_CODE}/align_deep_pca_gctw_interface.sh $INPUT_FOLDER $CLASS $TEST_SAMPLE $OUTPUT_FOLDER"
