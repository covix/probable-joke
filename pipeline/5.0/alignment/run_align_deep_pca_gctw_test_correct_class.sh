#!/bin/bash

TRAIN_FOLDER=$1  # organised in classes
TEST_FOLDER=$2  # organised in classes
OUTPUT_FOLDER=$3

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

for CLASS_FOLDER in `ls $TRAIN_FOLDER`
do
    echo "Started alignment for class " $class_folder 
    echo
    mkdir -p $OUTPUT_FOLDER/$CLASS_FOLDER

    for TEST_SAMPLE in `ls $TEST_FOLDER/$CLASS_FOLDER`
    do
        echo "Sample " $TEST_SAMPLE " is being aligned.."
        ${ENR_CODE}/run_align_deep_pca_gctw_test.sh $TRAIN_FOLDER $CLASS_FOLDER $TEST_FOLDER/$CLASS_FOLDER/$TEST_SAMPLE $OUTPUT_FOLDER/$CLASS_FOLDER
    done
done
