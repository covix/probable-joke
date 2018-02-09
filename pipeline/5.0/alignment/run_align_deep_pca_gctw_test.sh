#!/usr/bin/env bash

INPUT_FOLDER=$1
CLASS=$2
TEST_SAMPLE=$3
OUTPUT_FOLDER=$4
ANTERIOR=$5

NODE=nef020.inria.fr

ANTERIOR=`echo $ANTERIOR | tr : ' '`


ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

OAR_SUB_OUTPUT=`oarsub $ANTERIOR -l /core=7 -p "host='$NODE'" -n alignment_indexes_test_$CLASS -S "${ENR_CODE}/align_deep_pca_gctw_interface_test.sh $INPUT_FOLDER $CLASS $TEST_SAMPLE $OUTPUT_FOLDER"`
ID=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
echo $ID

# ${ENR_CODE}/align_deep_pca_gctw_interface_test.sh $INPUT_FOLDER $CLASS $TEST_SAMPLE $OUTPUT_FOLDER

# Usage:
# ./run_align_deep_pca_gctw_test.sh ../../../../experiments/datasets/train/pca_features_train/ 01 ../../../../experiments/datasets/test/pca_features_test/01-M-01-C-comp_features.csv bla
