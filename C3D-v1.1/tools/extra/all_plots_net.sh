#!/bin/bash

# STDERR_FILE=$1
LOG_FILES_RAW=${@}
FIRST_LOG=$1

echo $LOG_FILES_RAW

DIR="$( cd "$(dirname "$0")" ; pwd -P )"

LOG_DIR='logs'

mkdir -p $LOG_DIR


IDS=""
for i in $LOG_FILES_RAW;
do
    LOG_FILE=${LOG_DIR}/${i}.log
    
    cp $i ${LOG_FILE}
    
    ID=`echo $(basename $LOG_FILE) | cut -d. -f2`
    IDS=${IDS}_$ID

    LOG_FILES="${LOG_FILES} ${LOG_FILE}"
done


IDS=${IDS:1}

PLOT_FOLDER=$(dirname ${FIRST_LOG})/plots/${IDS}
mkdir -p $PLOT_FOLDER


for i in `seq 0 7`;
do
    echo $i
    python2 ${DIR}/plot_training_log.py $i $PLOT_FOLDER $LOG_FILES
done
