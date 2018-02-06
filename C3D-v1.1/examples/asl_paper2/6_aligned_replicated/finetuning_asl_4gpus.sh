SOLVER_FILE=$1

if [ ! -f activitynet_iter_135000.caffemodel ]; then
    echo "activitynet_iter_135000 not found, exiting"
    exit 1
fi

mkdir -p LOG_TRAIN

source /etc/profile.d/modules.sh
module load cuda/8.0
module load cudnn/5.1-cuda-8.0

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/sparks/share/nccl-master/lib

CAFFE_HOME=/data/sparks/share/R-C3D/caffe3d/

GLOG_log_dir="./LOG_TRAIN" $CAFFE_HOME/build/tools/caffe.bin train --solver=${SOLVER_FILE} --weights=activitynet_iter_135000.caffemodel --gpu=0,1,2,3
