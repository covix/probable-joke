#!/usr/bin/env bash

INPUT_FOLDER=$1
CLASS=$2
TEST_SAMPLE=$3
OUTPUT_FOLDER=$4

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

OAR_SUB_OUTPUT=`oarsub -l /core=1 -S "${ENR_CODE}/align_deep_pca_gctw_interface_test.sh $INPUT_FOLDER $CLASS $TEST_SAMPLE $OUTPUT_FOLDER"`
echo `echo $OAR_SUB_OUTPUT | cut -d'=' -f2

# ${ENR_CODE}/align_deep_pca_gctw_interface_test.sh $INPUT_FOLDER $CLASS $TEST_SAMPLE $OUTPUT_FOLDER

# Usage:
# ./run_align_deep_pca_gctw_test.sh ../../../../experiments/datasets/train/pca_features_train/ 01 ../../../../experiments/datasets/test/pca_features_test/01-M-01-C-comp_features.csv bla
