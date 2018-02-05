VIDEO_FOLDER=/data/sparks/share/asl/data/VideoThumbnailsMotion/
FRAMES_FOLDER=/data/sparks/share/asl/data/asl_png

TRAIN_LABELS=/data/sparks/share/asl/experiments/datasets/train.txt
TEST_LABELS=/data/sparks/share/asl/experiments/datasets/test.txt

TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train/original_train
TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/test/original_test

FEATURES_TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train/deep_features_train
FEATURES_TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/train/deep_features_test

SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/C3D-v1.1/scripts
PYTHON_SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/C3D-v1.1/python


MODEL_PATH=/data/sparks/share/video-caffe/models/bvlc_googlenet
NET=/data/sparks/share/video-caffe/models/bvlc_googlenet/deploy.prototxt
MEAN_FILE=/data/sparks/share/asl/imagenet_mean.binaryproto
LAYER="pool5/7x7_s1"


# exit form the script on failure
set -e

#Start pre-pipeline

if [[ ! -d $FRAMES_FOLDER ]]; then
    #Extract frames
    echo "Create extract frames..."
    mkdir -p $FRAMES_FOLDER
    sh $SCRIPTS_FOLDER/extract_frames.sh $VIDEO_FOLDER $FRAMES_FOLDER
    chmod 777 $FRAMES_FOLDER
else
    echo "Skipping extract frames"
fi


if [[ ! -d $TRAIN_FOLDER ]]; then
    #Create original_train
    echo "Create original_train..."
    mkdir -p $TRAIN_FOLDER
    sh $SCRIPTS_FOLDER/move_train_test.sh $TRAIN_LABELS $FRAMES_FOLDER $TRAIN_FOLDER
    chmod 777 $TRAIN_FOLDER
else
    echo "Skipping original_train"
fi


if [[ ! -d $TEST_FOLDER ]]; then
    #Create original_test
    echo "Create original_test..."
    mkdir -p $TEST_FOLDER
    sh $SCRIPTS_FOLDER/move_train_test.sh $TEST_LABELS $FRAMES_FOLDER $TEST_FOLDER
    chmod 777 $TEST_FOLDER
else
    echo "Skipping original_test"
fi


if [[ ! -d $FEATURES_TRAIN_FOLDER ]]; then
    #Create original_test
    echo "Extract features train..."
    mkdir -p $FEATURES_TRAIN_FOLDER
    sh $PYTHON_SCRIPTS_FOLDER/extract_features.py $TRAIN_FOLDER $MODEL_PATH $NET $MEAN_FILE $FEATURES_TRAIN_FOLDER $LAYER
    chmod 777 $TEST_FOLDER
else
    echo "Skipping extract features train"
fi
