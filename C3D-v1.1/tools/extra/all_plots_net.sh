#!/bin/bash

STDERR_FILE=$1

DIR="$( cd "$(dirname "$0")" ; pwd -P )"

LOG_FILE=${STDERR_FILE}.log
ID=`echo $(basename $STDERR_FILE) | cut -d. -f2`
PLOT_FOLDER=$(dirname ${STDERR_FILE})/plots/${ID}

mkdir -p $PLOT_FOLDER

cp $STDERR_FILE $LOG_FILE

for i in `seq 0 7`;
do
    echo $i
    python ${DIR}/plot_training_log.py $i $PLOT_FOLDER $LOG_FILE
done

rm $LOG_FILE
