#!/bin/bash

SOLVER_FILE=$1
NUM_GPUS=$2

if [ ! -f c3d_resnet18_sports1m_r2_iter_2800000.caffemodel ]; then
    echo "activitynet_iter_135000 not found, exiting"
    exit 1
fi

mkdir -p LOG_TRAIN

source /etc/profile.d/modules.sh
module load cuda/8.0
module load cudnn/5.1-cuda-8.0

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/sparks/share/nccl-master/lib

CAFFE_HOME=/data/sparks/share/R-C3D/caffe3d/

GPUS=

for i in `seq 1 $NUM_GPUS`;
do
    GPUS=$GPUS,$i
done
GPUS=${GPUS:1}


GLOG_log_dir="./LOG_TRAIN" $CAFFE_HOME/build/tools/caffe.bin train --solver=${SOLVER_FILE} --weights=activitynet_iter_135000.caffemodel --gpu=$GPUS
