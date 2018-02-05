$VIDEO_FOLDER=
$FRAMES_FOLDER=
$TRAIN_LABELS=
$TEST_LABELS=
$TRAIN_FOLDER=
$TEST_FOLDER=

$SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/C3D-v1.1/scripts

# exit form the script on failure
set -e

#Start pre-pipeline

if [[ ! -d $FRAMES_FOLDER ]]; then
    #Extract frames
    echo "Create extract frames"
    sh extract_frames.sh $VIDEO_FOLDER $FRAMES_FOLDER
    chmod 777 $FRAMES_FOLDER
else
    echo "Skipping extract frames"
fi

if [[ ! -d $TRAIN_FOLDER ]]; then
    #Create original_train
    echo "Create original_train..."
    sh $SCRIPTS_FOLDER/move_train_test.sh $TRAIN_LABELS $FRAMES_FOLDER $TRAIN_FOLDER
    chmod 777 $TRAIN_FOLDER
else
    echo "Skipping original_train"
fi

if [[ ! -d $TEST_FOLDER ]]; then
    #Create original_test
    echo "Create original_test"
    sh $SCRIPTS_FOLDER/move_train_test.sh $TEST_LABELS $FRAMES_FOLDER $TEST_FOLDER
    chmod 777 $TEST_FOLDER
else
    echo "Skipping original_test"
fi
