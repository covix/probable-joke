#!/bin/bash

INPUT_FOLDER=$1
OUTPUT_FOLDER=${2:-$INPUT_FOLDER}

for i in $INPUT_FOLDER/*M*.avi;
do
    name="${i##*/}"
    echo $name;
    avconv -i "$i" -vcodec libx264 -acodec aac -strict experimental -y -v 0 "${OUTPUT_FOLDER}/${name}.mp4";
done
