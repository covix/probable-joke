#!/bin/bash
# Renames files in folders in INPUT_FOLDER by replacing OLD_EXTENSION NEW_EXTENSION

INPUT_FOLDER=$1
OLD_EXTENSION=${2:-png}
NEW_EXTENSION=${3:-jpg}

for video in "$INPUT_FOLDER"/*
do
  for i in "$video"/*
    do
      for f in "$i"/*."$OLD_EXTENSION"
      do
        filename=${f##*/}
        filename="${filename%.*}"
        echo mv $f $i/$filename.$NEW_EXTENSION
    done
  done
done

# Usage example
# ./rename_extension.sh ../data/test_asl/ png jpg
