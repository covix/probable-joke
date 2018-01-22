NETWORK_FILE=$1
WEIGHTS=$2

source /etc/profile.d/modules.sh
module load cuda/8.0
module load cuda/7.5
module load cudnn/5.0

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/sparks/share/nccl-master/lib

# CAFFE_HOME=/data/sparks/share/C3D/C3D-v1.1/
# CAFFE_HOME=/data/sparks/share/video-caffe/
CAFFE_HOME=/data/sparks/share/R-C3D/caffe3d/

GLOG_log_dir="./LOG_TRAIN" $CAFFE_HOME/build/tools/caffe.bin test --model=$NETWORK_FILE --weights=$WEIGHTS --gpu=0 --iterations=1
