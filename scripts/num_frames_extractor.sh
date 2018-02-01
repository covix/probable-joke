#!/bin/bash

FOLDER=$1

:>num_frames.txt

for i in `seq -w 1 43`;
do
    for j in `seq -w 1 14`;
    do
        for k in 'C' 'D';
        do
            echo $j $i $k `ls $FOLDER/$j-M-$i-$k-comp  | wc -l` >> num_frames.txt
        done
    done
done


# Usage example
# ./num_frames_extractor.sh /Users/covix/Projects/probable-joke/data/asl
