#!/bin/bash

INPUT_FOLDER=$1

for i in $INPUT_FOLDER/*.avi;
do
    name="${i%.*}";
    # ffmpeg -v 1 -y -vcodec h264 -i "$i" "$name.mp4";
    avconv -i "$i" -vcodec libx264 -acodec aac -strict experimental -y -v 0 "$name.mp4";  
done

