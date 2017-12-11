#!/bin/bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=${2:-$INPUT_FOLDER}

# for i in $INPUT_FOLDER/*M*;
for i in `find $INPUT_FOLDER -type f -name "*M*.mp4"`
do
    name="${i##*/}"
    name="${name%.*}"

    echo $name
    # avconv -i "$i" -vcodec libx264 -acodec aac -strict experimental -y -v 0 "${outfile}.mp4"
    mkdir -p ${OUTPUT_FOLDER}/${name}
    ffmpeg -v 0 -i $i ${OUTPUT_FOLDER}/${name}/%06d.jpg
done
