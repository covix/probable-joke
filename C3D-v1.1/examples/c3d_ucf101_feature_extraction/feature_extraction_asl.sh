if [ ! -f c3d_resnet18_sports1m_r2_iter_2800000.caffemodel ];then
	wget https://www.dropbox.com/s/qqfrg6h44d4jb46/c3d_resnet18_sports1m_r2_iter_2800000.caffemodel
fi

GPU_ID=0
BATCH_SIZE=1
BATCH_NUMBERS=1

source /etc/profile.d/modules.sh
module load cuda/8.0
module load cudnn/5.0

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/sparks/share/nccl-master/lib

CAFFE_HOME=/data/sparks/share/C3D/C3D-v1.1/

GLOG_logtostderr=1 ${CAFFE_HOME}/build/tools/extract_image_features.bin c3d_sport1m_feature_extractor_frm_v1.1.prototxt conv3d_deepnetA_sport1m_iter_1900000_v1.1.caffemodel $GPU_ID $BATCH_SIZE $BATCH_NUMBERS asl_video_frame.prefix pool5 conv5b
