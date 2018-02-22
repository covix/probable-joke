#!/bin/bash

FOLDER=$1

# :>num_frames.txt

for i in `seq -w 1 43`;
do
    for j in `seq -w 1 14`;
    do
        for k in 'C' 'D';
        do
            if [ -d "$FOLDER/$j-M-$i-$k-comp" ]; then
                echo $j $i $k `ls $FOLDER/$j-M-$i-$k-comp  | wc -l` # >> num_frames.txt
            fi
        done
    done
done


# Usage example
# ./num_frames_extractor.sh /Users/covix/Projects/probable-joke/data/asl

# > num_frames.txt
# ./num_frames_extractor.sh ../../experiments/datasets/train/loud_train/ >> num_frames.txt
# ./num_frames_extractor.sh ../../experiments/datasets/test/loud_test/ >> num_frames.txt
# cat num_frames.txt | sort > num_frames_loud.txt