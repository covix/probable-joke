#!/bin/bash
LABELS_FILE=$1
DATA_FOLDER=$2
OUTPUT_FOLDER=$3
for l in cat $LABELS_FILE | cut -d' ' -f1;
do
  echo cp -r $DATA_FOLDER/$l $OUTPUT_FOLDER/$l
done
