# Used to extract features from every frame using AlexNet

DIR=examples/frames_features

mkdir -p $DIR

cp examples/asl/files.txt > example/frames_features/files.txt
sed "s/$/ 0/" $DIR/files.txt > $DIR/file_list.txt

# if [ ! -f c3d_resnet18_sports1m_r2_iter_2800000.caffemodel ]; then
if [ ! -f data/ilsvrc12/imagenet_mean.binaryproto ]; then
    data/ilsvrc12/get_ilsvrc_aux.sh
fi

if [ ! -f models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel ]; then
    scripts/download_model_binary.py models/bvlc_reference_caffenet
fi

cp examples/feature_extraction/imagenet_val.prototxt $DIR

./build/tools/extract_features.bin models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel $DIR/imagenet_val.prototxt conv5 $DIR/features 10 leveldb
