#!/bin/bash

TRAIN_FOLDER=$1  # organised in classes
TEST_FOLDER=$2  # organised in classes
OUTPUT_FOLDER=$3
ORIGINAL_FOLDER=$4  # stiamo imbrogliando
ID1=$5
ID2=$6

ID="$ID1:$ID2"

ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files

for CLASS_FOLDER in {01..43}
do
    echo "Queueing alignment for class " $CLASS_FOLDER
    echo
    mkdir -p $OUTPUT_FOLDER/$CLASS_FOLDER
    # WAIT_ID=$ID
    # ID=
    echo "WAIT_ID is: $WAIT_ID"

    for TEST_SAMPLE in `ls $ORIGINAL_FOLDER | grep "\-$CLASS_FOLDER\-"`
    do
        echo "Sample $TEST_SAMPLE will be aligned.."
        CMD="${ENR_CODE}/run_align_deep_pca_gctw_test.sh $TRAIN_FOLDER $CLASS_FOLDER $TEST_FOLDER/$CLASS_FOLDER/${TEST_SAMPLE}_features.csv $OUTPUT_FOLDER/$CLASS_FOLDER $ID"
        # ID="--anterior=$($CMD):$ID"
        ID="--anterior=$($CMD)"
        echo $ID
    done
done

echo "ANTERIOR=$ID"
