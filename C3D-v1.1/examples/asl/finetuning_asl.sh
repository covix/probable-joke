if [ ! -f c3d_resnet18_sports1m_r2_iter_2800000.caffemodel ]; then
	wget https://www.dropbox.com/s/qqfrg6h44d4jb46/c3d_resnet18_sports1m_r2_iter_2800000.caffemodel
fi

mkdir -p LOG_TRAIN

source /etc/profile.d/modules.sh
module load cuda/7.5
module load cudnn/5.0

GLOG_log_dir="./LOG_TRAIN" ../../build/tools/caffe.bin train --solver=solver_r2_asl.prototxt --weights=c3d_resnet18_sports1m_r2_iter_2800000.caffemodel --gpu=0,1,2,3
