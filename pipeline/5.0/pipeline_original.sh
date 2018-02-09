#!/bin/bash

TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train
TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/test
SCRIPTS_FOLDER=/data/sparks/share/asl/experiments/datasets/scripts_data
PYTHON_SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/C3D-v1.1/python
BASH_SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/C3D-v1.1/scripts
ALIGNMENT_SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/pipeline/5.0/alignment

ORIGINAL_FRAMES_TRAIN=$TRAIN_FOLDER/original_train
ORIGINAL_FEATURES_TRAIN=$TRAIN_FOLDER/deep_features_train

ORIGINAL_FRAMES_TEST=$TEST_FOLDER/original_test
ORIGINAL_FEATURES_TEST=$TEST_FOLDER/deep_features_test

ORIGINAL_FRAMES_CLASS_TRAIN=$TRAIN_FOLDER/original_frames_class_train
ORIGINAL_FRAMES_CLASS_TEST=$TEST_FOLDER/original_frames_class_test

ORIGINAL_PCA_FEATURES_TRAIN=$TRAIN_FOLDER/pca_features_original_train
ORIGINAL_PCA_FEATURES_TEST=$TEST_FOLDER/pca_features_original_test
PCA_MODEL="/data/sparks/share/asl/experiments/datasets/train/pca_original_train.pkl"

ORIGINAL_PCA_FEATURES_CLASS_TRAIN=$TRAIN_FOLDER/pca_features_original_class_train
ORIGINAL_PCA_FEATURES_CLASS_TEST=$TEST_FOLDER/pca_features_original_class_test

ORIGINAL_ALIGNMENT_INDEXES_TRAIN=$TRAIN_FOLDER/alignment_indexes_original_train
ORIGINAL_ALIGNMENT_INDEXES_TEST=$TEST_FOLDER/alignment_indexes_original_test

ORIGINAL_ALIGNED_FRAMES_TRAIN=$TRAIN_FOLDER/aligned_frames_original_train
ORIGINAL_ALIGNED_FRAMES_TEST=$TEST_FOLDER/aligned_frames_original_test

TRAIN_FOLDER_REDUCED_FPS=/data/sparks/share/asl/experiments/datasets/train/aligned_reduced_fps_original_train
TEST_FOLDER_REDUCED_FPS=/data/sparks/share/asl/experiments/datasets/test/aligned_reduced_fps_original_test
FPS="7.5"
LENGTH="45"


# exit form the script on failure
set -e

ANTERIOR_ORIGINAL_FRAMES_TRAIN=
ANTERIOR_ORIGINAL_FRAMES_TEST=

ANTERIOR_ORIGINAL_FEATURES_TRAIN=
ANTERIOR_ORIGINAL_FEATURES_TEST=

ANTERIOR_ORIGINAL_PCA_FEATURES_TRAIN=
ANTERIOR_ORIGINAL_PCA_FEATURES_TEST=

ANTERIOR_ORIGINAL_FRAMES_CLASS_TRAIN=
ANTERIOR_ORIGINAL_FRAMES_CLASS_TEST=

ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TRAIN=
ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TEST=


#--- Get PCA features -------------------------------------------------------------------

if [[ ! -d $ORIGINAL_PCA_FEATURES_TRAIN ]]; then
    echo "Applying PCA on train..."
    mkdir -p $ORIGINAL_PCA_FEATURES_TRAIN
    touch $PCA_MODEL
    chmod 777 $PCA_MODEL
    CMD="./python_pipeline_wrapper.sh $PYTHON_SCRIPTS_FOLDER/apply_pca.py $ORIGINAL_FEATURES_TRAIN $ORIGINAL_PCA_FEATURES_TRAIN 15 $PCA_MODEL"
    echo oarsub $ANTERIOR_ORIGINAL_FEATURES_TRAIN -l /core=10 -S "$CMD"
    OAR_SUB_OUTPUT=`oarsub -n original_pca_features_train $ANTERIOR_ORIGINAL_FEATURES_TRAIN -l /core=10 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_PCA_FEATURES_TRAIN=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_PCA_FEATURES_TRAIN="--anterior=$ANTERIOR_ORIGINAL_PCA_FEATURES_TRAIN"
    chmod -R 777 $ORIGINAL_PCA_FEATURES_TRAIN
else
    echo "Skipping PCA on train"
fi


if [[ ! -d $ORIGINAL_PCA_FEATURES_TEST ]]; then
    echo "Applying PCA on test..."
    mkdir -p $ORIGINAL_PCA_FEATURES_TEST
    CMD="./python_pipeline_wrapper.sh $PYTHON_SCRIPTS_FOLDER/apply_pca_model.py $ORIGINAL_FEATURES_TEST $ORIGINAL_PCA_FEATURES_TEST $PCA_MODEL"
    echo oarsub $ANTERIOR_ORIGINAL_FEATURES_TRAIN $ANTERIOR_ORIGINAL_FEATURES_TEST -l /core=10 -S $CMD
    OAR_SUB_OUTPUT=`oarsub -n original_pca_features_test $ANTERIOR_ORIGINAL_FEATURES_TEST $ANTERIOR_ORIGINAL_PCA_FEATURES_TRAIN -l /core=10 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_PCA_FEATURES_TEST=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_PCA_FEATURES_TEST="--anterior=$ANTERIOR_ORIGINAL_PCA_FEATURES_TEST"
    chmod -R 777 $ORIGINAL_PCA_FEATURES_TEST
else
    echo "Skipping PCA on test"
fi


#--- Moving frames by class -------------------------------------------------------------

if [[ ! -d $ORIGINAL_FRAMES_CLASS_TRAIN ]]; then
    # Moving by class train
    echo "Moving train frames by class..."
    mkdir -p $ORIGINAL_FRAMES_CLASS_TRAIN
    CMD="$SCRIPTS_FOLDER/move_frames.sh $ORIGINAL_FRAMES_TRAIN $ORIGINAL_FRAMES_CLASS_TRAIN"
    OAR_SUB_OUTPUT=`oarsub -n original_frames_class_train $ANTERIOR_ORIGINAL_FRAMES_TRAIN -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_FRAMES_CLASS_TRAIN=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_FRAMES_CLASS_TRAIN="--anterior=$ANTERIOR_ORIGINAL_FRAMES_CLASS_TRAIN"
    chmod -R 777 $ORIGINAL_FRAMES_CLASS_TRAIN
else
    echo "Skipping moving train frames"
fi


if [[ ! -d $ORIGINAL_FRAMES_CLASS_TEST ]]; then
    # Moving by class test
    echo "Moving test frames by class..."
    mkdir -p $ORIGINAL_FRAMES_CLASS_TEST
    CMD="$SCRIPTS_FOLDER/move_frames.sh $ORIGINAL_FRAMES_TEST $ORIGINAL_FRAMES_CLASS_TEST"
    OAR_SUB_OUTPUT=`oarsub -n original_frames_class_test $ANTERIOR_ORIGINAL_FRAMES_TEST -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_FRAMES_CLASS_TEST=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_FRAMES_CLASS_TEST="--anterior=$ANTERIOR_ORIGINAL_FRAMES_CLASS_TEST"
    chmod -R 777 $ORIGINAL_FRAMES_CLASS_TEST
else
    echo "Skipping moving test frames"
fi


#--- Moving features by class -----------------------------------------------------------

if [[ ! -d $ORIGINAL_PCA_FEATURES_CLASS_TRAIN ]]; then
    # Moving by class train
    echo "Moving train features by class..."
    mkdir -p $ORIGINAL_PCA_FEATURES_CLASS_TRAIN
    CMD="$SCRIPTS_FOLDER/move_frames.sh $ORIGINAL_PCA_FEATURES_TRAIN $ORIGINAL_PCA_FEATURES_CLASS_TRAIN"
    OAR_SUB_OUTPUT=`oarsub -n original_pca_features_class_train $ANTERIOR_ORIGINAL_PCA_FEATURES_TRAIN -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TRAIN=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TRAIN="--anterior=$ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TRAIN"
    chmod -R 777 $ORIGINAL_PCA_FEATURES_CLASS_TRAIN
else
    echo "Skipping moving train features by class"
fi


if [[ ! -d $ORIGINAL_PCA_FEATURES_CLASS_TEST ]]; then
    # Moving by class test
    echo "Moving test features by class..."
    mkdir -p $ORIGINAL_PCA_FEATURES_CLASS_TEST
    CMD="$SCRIPTS_FOLDER/move_frames.sh $ORIGINAL_PCA_FEATURES_TEST $ORIGINAL_PCA_FEATURES_CLASS_TEST"
    OAR_SUB_OUTPUT=`oarsub -n original_pca_features_class_test $ANTERIOR_ORIGINAL_PCA_FEATURES_TEST -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TEST=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TEST="--anterior=$ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TEST"
    chmod -R 777 $ORIGINAL_PCA_FEATURES_CLASS_TEST
else
    echo "Skipping moving test features by class"
fi


#--- Alignment --------------------------------------------------------------------------

if [[ ! -d $ORIGINAL_ALIGNMENT_INDEXES_TRAIN ]]; then
    # Aligning train
    echo "Aligning train features by class..."
    mkdir -p $ORIGINAL_ALIGNMENT_INDEXES_TRAIN
    CMD="$ALIGNMENT_SCRIPTS_FOLDER/run_align_deep_pca_gctw_train.sh $ORIGINAL_PCA_FEATURES_CLASS_TRAIN $ORIGINAL_ALIGNMENT_INDEXES_TRAIN"
    OAR_SUB_OUTPUT=`oarsub -n original_alignment_indexes_train $ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TRAIN -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TRAIN=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TRAIN="--anterior=$ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TRAIN"
    chmod -R 777 $ORIGINAL_ALIGNMENT_INDEXES_TRAIN
else
    echo "Skipping aligning train features by class"
fi


#if [[ ! -d $ORIGINAL_ALIGNMENT_INDEXES_TEST ]]; then
    # Aligning test
    echo "Aligning test features by class..."
    mkdir -p $ORIGINAL_ALIGNMENT_INDEXES_TEST
    CMD="$ALIGNMENT_SCRIPTS_FOLDER/run_align_deep_pca_gctw_test_correct_class.sh $ORIGINAL_PCA_FEATURES_CLASS_TRAIN $ORIGINAL_PCA_FEATURES_CLASS_TEST $ORIGINAL_ALIGNMENT_INDEXES_TEST $ORIGINAL_FEATURES_TEST $ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TRAIN $ANTERIOR_ORIGINAL_PCA_FEATURES_CLASS_TEST"
    echo "$CMD"
    OAR_SUB_OUTPUT=$($CMD)
    ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TEST=${OAR_SUB_OUTPUT#*ANTERIOR=}
    ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TEST=`echo $ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TEST | tr : ' '`
    chmod -R 777 $ORIGINAL_ALIGNMENT_INDEXES_TEST
#else
#    echo "Skipping aligning test features by class"
#fi


#--- Aligned frames extraction ----------------------------------------------------------

if [[ ! -d $ORIGINAL_ALIGNED_FRAMES_TRAIN ]]; then
    # Extract aligned frames train
    echo "Extracting aligned train frames..."
    mkdir -p $ORIGINAL_ALIGNED_FRAMES_TRAIN
    CMD="$PYTHON_SCRIPTS_FOLDER/extract_aligned_frames_from_indexes_interface.sh $ORIGINAL_FRAMES_CLASS_TRAIN $ORIGINAL_ALIGNMENT_INDEXES_TRAIN $ORIGINAL_ALIGNED_FRAMES_TRAIN"
    OAR_SUB_OUTPUT=`oarsub -n original_aligned_frames_train $ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TRAIN $ANTERIOR_ORIGINAL_FRAMES_CLASS_TRAIN -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TRAIN=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TRAIN="--anterior=$ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TRAIN"
    chmod -R 777 $ORIGINAL_ALIGNED_FRAMES_TRAIN
else
    echo "Skipping extracting aligned train frames"
fi


if [[ ! -d $ORIGINAL_ALIGNED_FRAMES_TEST ]]; then
    # Extract aligned frames test
    echo "Extracting aligned test frames..."
    mkdir -p $ORIGINAL_ALIGNED_FRAMES_TEST
    CMD="$PYTHON_SCRIPTS_FOLDER/frames_from_indexes_sample.sh $ORIGINAL_FRAMES_TEST $ORIGINAL_ALIGNMENT_INDEXES_TEST $ORIGINAL_ALIGNED_FRAMES_TEST"
    OAR_SUB_OUTPUT=`oarsub -n original_aligned_frames_test $ANTERIOR_ORIGINAL_ALIGNMENT_INDEXES_TEST $ANTERIOR_ORIGINAL_FRAMES_TEST -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TEST=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TEST="--anterior=$ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TEST"
    chmod -R 777 $ORIGINAL_ALIGNED_FRAMES_TEST
else
    echo "Skipping extracting aligned test frames"
fi


#--- Reduce fps and pad with silence ----------------------------------------------------

if [[ ! -d $TRAIN_FOLDER_REDUCED_FPS ]]; then
    #Create reduced fps train
    echo "Create reduced fps train..."
    mkdir -p $TRAIN_FOLDER_REDUCED_FPS
    # python $PYTHON_SCRIPTS_FOLDER/reduce_fps_parallel.py $ORIGINAL_ALIGNED_FRAMES_TRAIN $TRAIN_FOLDER_REDUCED_FPS $FPS
    # python $PYTHON_SCRIPTS_FOLDER/replicate_last_frame_parallel.py $TRAIN_FOLDER_REDUCED_FPS $LENGTH
    CMD="$PYTHON_SCRIPTS_FOLDER/reduce_fps_and_pad_interface.sh $ORIGINAL_ALIGNED_FRAMES_TRAIN $TRAIN_FOLDER_REDUCED_FPS $FPS $LENGTH"
    OAR_SUB_OUTPUT=`oarsub -n train_folder_reduced_fps $ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TRAIN -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_TRAIN_FOLDER_REDUCED_FPS=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_TRAIN_FOLDER_REDUCED_FPS="--anterior=$ANTERIOR_TRAIN_FOLDER_REDUCED_FPS"
    chmod -R 777 $TRAIN_FOLDER_REDUCED_FPS
else
    echo "Skipping reduced fps train"
fi


if [[ ! -d $TEST_FOLDER_REDUCED_FPS ]]; then
    #Create reduced fps test
    echo "Create reduced fps test..."
    mkdir -p $TEST_FOLDER_REDUCED_FPS
    # python $PYTHON_SCRIPTS_FOLDER/reduce_fps_parallel.py $ORIGINAL_ALIGNED_FRAMES_TEST $TEST_FOLDER_REDUCED_FPS $FPS
    # python $PYTHON_SCRIPTS_FOLDER/replicate_last_frame_parallel.py $TEST_FOLDER_REDUCED_FPS $LENGTH
    CMD="$PYTHON_SCRIPTS_FOLDER/reduce_fps_and_pad_interface.sh $ORIGINAL_ALIGNED_FRAMES_TEST $TEST_FOLDER_REDUCED_FPS $FPS $LENGTH"
    OAR_SUB_OUTPUT=`oarsub -n test_folder_reduced_fps $ANTERIOR_ORIGINAL_ALIGNED_FRAMES_TEST -l /core=1 -S "$CMD"`
    echo $OAR_SUB_OUTPUT
    ANTERIOR_TEST_FOLDER_REDUCED_FPS=`echo $OAR_SUB_OUTPUT | cut -d'=' -f2`
    ANTERIOR_TEST_FOLDER_REDUCED_FPS="--anterior=$ANTERIOR_TEST_FOLDER_REDUCED_FPS"
    chmod -R 777 $TEST_FOLDER_REDUCED_FPS
else
    echo "Skipping reduced fps test"
fi

echo "Changing extension train..."
CMD="$BASH_SCRIPTS_FOLDER/rename_extension.sh $TRAIN_FOLDER_REDUCED_FPS"
OAR_SUB_OUTPUT=`oarsub -n change_extension $ANTERIOR_TRAIN_FOLDER_REDUCED_FPS -l /core=1 -S "$CMD"`
echo $OAR_SUB_OUTPUT

echo "Changing extension test..."
CMD="$BASH_SCRIPTS_FOLDER/rename_extension.sh $TEST_FOLDER_REDUCED_FPS"
OAR_SUB_OUTPUT=`oarsub -n change_extension $ANTERIOR_TEST_FOLDER_REDUCED_FPS -l /core=1 -S "$CMD"`
echo $OAR_SUB_OUTPUT


#--- Unify videos -----------------------------------------------------------------------
