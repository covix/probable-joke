#!/usr/bin/env bash

INPUTFOLDER=${1:-data/asl/} # Folder containing the folders with viedoframes
OUTPUTFOLDER=${2:-examples/_asl_features/} # output folder for features


ENR_CODE=`dirname $0`  # Current folder


for framesfolder in `ls $INPUTFOLDER`
do

# Creating folders to save features into
featurefolder=$OUTPUTFOLDER$framesfolder
mkdir -p $featurefolder

# Extract features
echo 'Extracting features for video:' $framesfolder
$ENR_CODE/extract_alexnet_features.sh $framesfolder $featurefolder

done
