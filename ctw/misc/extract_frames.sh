#!/bin/bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=${2:-$INPUT_FOLDER}
FORMAT=${3:-mp4}

for i in `find $INPUT_FOLDER -type f -name "*M*.${FORMAT}"`
do
    name="${i##*/}"
    name="${name%.*}"

    echo $name
    mkdir -p ${OUTPUT_FOLDER}/${name}
    ffmpeg -v 0 -i $i ${OUTPUT_FOLDER}/${name}/image_%05d.jpg
done
