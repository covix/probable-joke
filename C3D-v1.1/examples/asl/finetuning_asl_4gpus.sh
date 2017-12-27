if [ ! -f c3d_resnet18_sports1m_r2_iter_2800000.caffemodel ]; then
	wget https://www.dropbox.com/s/qqfrg6h44d4jb46/c3d_resnet18_sports1m_r2_iter_2800000.caffemodel
fi

mkdir -p LOG_TRAIN

source /etc/profile.d/modules.sh
module load cuda/8.0
module load cudnn/5.0

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/sparks/share/nccl-master/lib

CAFFE_HOME=/data/sparks/share/C3D/C3D-v1.1/

GLOG_log_dir="./LOG_TRAIN" $CAFFE_HOME/build/tools/caffe.bin train --solver=solver_r2_asl.prototxt --weights=c3d_resnet18_sports1m_r2_iter_2800000.caffemodel --gpu=0,1,2,3
