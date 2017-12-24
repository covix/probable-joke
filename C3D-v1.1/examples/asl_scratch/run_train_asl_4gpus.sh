mkdir -p LOG_TRAIN

source /etc/profile.d/modules.sh
module load cuda/8.0
module load cudnn/5.0

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/sparks/share/nccl-master/lib

GLOG_log_dir="./LOG_TRAIN" ../../build/tools/caffe.bin train --solver=solver_r2_asl.prototxt --gpu=0,1,2,3
