#!/usr/bin/env bash

# entry point for higher level scipt

INPUTFOLDER=${1:-data/asl/} # Folder containing the folders with viedoframes
OUTPUTFOLDER=${2:-examples/_asl_features/} # output folder for features

ENR_CODE=`dirname $0`  # Current folder
echo $ENR_CODE
${ENR_CODE}/deep_feature_extraction_interface.sh $INPUTFOLDER $OUTPUTFOLDER

# Usage example:
# ./run_deep_feature_extraction.sh ../../../pipeline_data/asl/ ../../../pipeline_data/_asl_features/
