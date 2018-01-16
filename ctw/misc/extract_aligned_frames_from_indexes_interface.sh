#!/bin/bash

INPUT_FOLDER=$1
ALIGNMENT_FOLDER=$2
OUTPUT_FOLDER=$3

for i in {01..43};
do
    echo $i
    python extract_aligned_frames_from_indexes.py ${INPUT_FOLDER}/$i/ "$ALIGNMENT_FOLDER/ali_gctw_deep_${i}_P.csv" $OUTPUT_FOLDER/
done
