#!/bin/bash

LOUD_ALIGNED_FRAMES=$1
FOLDER_REDUCED_FPS=$2
FPS=$3
LENGTH=$4

ENR_DIR=`dirname $0`

python $ENR_DIR/reduce_fps_parallel.py $LOUD_ALIGNED_FRAMES $FOLDER_REDUCED_FPS $FPS
python $ENR_DIR/replicate_last_frame_parallel.py $FOLDER_REDUCED_FPS $LENGTH
