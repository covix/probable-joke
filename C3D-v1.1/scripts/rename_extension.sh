#!/bin/bash
# Renames files in folders in INPUT_FOLDER by replacing OLD_EXTENSION NEW_EXTENSION

INPUT_FOLDER=$1
OLD_EXTENSION=${2:-png}
NEW_EXTENSION=${3:-jpg}

for i in "$INPUT_FOLDER"/*
do
    for f in "$i"/*."$OLD_EXTENSION"
    do
      filename=${f##*/}
      filename="${filename%.*}"
      mv $f $i/$filename.$NEW_EXTENSION
  done
done
