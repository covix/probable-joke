TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train
TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/test
SCRIPTS_FOLDER=/data/sparks/share/asl/experiments/datasets/scripts_data
PYTHON_SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/C3D-v1.1/python
ALIGNMENT_SCRIPTS_FOLDER=/data/sparks/share/asl/probable-joke/pipeline/5.0/alignment

ORIGINAL_FRAMES_TRAIN=$TRAIN_FOLDER/original_train
ORIGINAL_FEATURES_TRAIN=$TRAIN_FOLDER/deep_features_train
LOUD_FEATURES_TRAIN=$TRAIN_FOLDER/deep_features_loud_train
LOUD_FRAMES_TRAIN=$TRAIN_FOLDER/loud_train

ORIGINAL_FRAMES_TEST=$TEST_FOLDER/original_test
ORIGINAL_FEATURES_TEST=$TEST_FOLDER/deep_features_test
LOUD_FEATURES_TEST=$TEST_FOLDER/deep_features_loud_test
LOUD_FRAMES_TEST=$TEST_FOLDER/loud_test

LOUD_FRAMES_CLASS_TRAIN=$TRAIN_FOLDER/loud_frames_class_train
LOUD_FRAMES_CLASS_TEST=$TEST_FOLDER/loud_frames_class_test

LOUD_PCA_FEATURES_TRAIN=$TRAIN_FOLDER/pca_features_loud_train
LOUD_PCA_FEATURES_TEST=$TEST_FOLDER/pca_features_loud_test
PCA_MODEL="/data/sparks/share/asl/experiments/datasets/train/pca_loud_train.pkl"

LOUD_PCA_FEATURES_CLASS_TRAIN=$TRAIN_FOLDER/pca_features_loud_class_train
LOUD_PCA_FEATURES_CLASS_TEST=$TEST_FOLDER/pca_features_loud_class_test

LOUD_ALIGNMENT_INDEXES_TRAIN=$TRAIN_FOLDER/alignment_indexes_loud_train
LOUD_ALIGNMENT_INDEXES_TEST=$TEST_FOLDER/alignment_indexes_loud_test

LOUD_ALIGNED_FRAMES_TRAIN=$TRAIN_FOLDER/aligned_frames_train
LOUD_ALIGNED_FRAMES_TEST=$TEST_FOLDER/aligned_frames_test

TRAIN_FOLDER_REDUCED_FPS=/data/sparks/share/asl/experiments/datasets/train/aligned_reduced_fps_train
TEST_FOLDER_REDUCED_FPS=/data/sparks/share/asl/experiments/datasets/test/aligned_reduced_fps_test
FPS="7.5"
LENGTH="45"


# exit form the script on failure
set -e


# check if the folder already exists, if so pass to the next step
if [[ ! -d $LOUD_FRAMES_TRAIN ]]; then
    #Create loud_train
    echo "Create loud_train..."
    sh $SCRIPTS_FOLDER/clean_silence_frames.sh $ORIGINAL_FEATURES_TRAIN $ORIGINAL_FRAMES_TRAIN $LOUD_FRAMES_TRAIN
    chmod 777 $LOUD_FRAMES_TRAIN
else
    echo "Skipping loud_train"
fi


if [[ ! -d $LOUD_FEATURES_TRAIN ]]; then
    #Create loud_train_features
    echo "Create loud_train_features..."
    sh $SCRIPTS_FOLDER/clean_silence_features.sh $ORIGINAL_FEATURES_TRAIN $LOUD_FEATURES_TRAIN
    chmod 777 $LOUD_FEATURES_TRAIN
else
    echo "Skipping loud_train_features"

fi


if [[ ! -d $LOUD_FRAMES_TEST ]]; then
    #Create loud_test
    echo "Create loud_test..."
    sh $SCRIPTS_FOLDER/clean_silence_frames.sh $ORIGINAL_FEATURES_TEST $ORIGINAL_FRAMES_TEST $LOUD_FRAMES_TEST
    chmod 777 $LOUD_FRAMES_TEST
else
    echo "Skipping loud_test"
fi


if [[ ! -d $LOUD_FEATURES_TEST ]]; then
    #Create loud_test_features
    echo "Create loud_test_features..."
    sh $SCRIPTS_FOLDER/clean_silence_features.sh $ORIGINAL_FEATURES_TEST $LOUD_FEATURES_TEST
    chmod 777 $LOUD_FEATURES_TEST
else
    echo "Skipping loud_test_features"
fi


#--- Get PCA features -------------------------------------------------------------------

if [[ ! -d $LOUD_PCA_FEATURES_TRAIN ]]; then
    echo "Applying PCA on train..."
    mkdir -p $LOUD_PCA_FEATURES_TRAIN
    python $PYTHON_SCRIPTS_FOLDER/apply_pca.py $LOUD_FEATURES_TRAIN $LOUD_PCA_FEATURES_TRAIN 15
    chmod 777 $LOUD_PCA_FEATURES_TRAIN
else
    echo "Skipping PCA on train"
fi


if [[ ! -d $LOUD_PCA_FEATURES_TEST ]]; then
    echo "Applying PCA on test..."
    mkdir -p $LOUD_PCA_FEATURES_TEST
    python $PYTHON_SCRIPTS_FOLDER/apply_pca_model.py $LOUD_FEATURES_TEST $LOUD_PCA_FEATURES_TEST PCA_MODEL
    chmod 777 $LOUD_PCA_FEATURES_TEST
else
    echo "Skipping PCA on test"
fi


#--- Moving frames by class -------------------------------------------------------------

if [[ ! -d $LOUD_FRAMES_CLASS_TRAIN ]]; then
    # Moving by class train
    echo "Moving train frames by class..."
    sh $SCRIPTS_FOLDER/move_frames.sh $LOUD_FRAMES_TRAIN $LOUD_FRAMES_CLASS_TRAIN
    chmod 777 $LOUD_FRAMES_CLASS_TRAIN
else
    echo "Skipping moving train frames"
fi


if [[ ! -d $LOUD_FRAMES_CLASS_TEST ]]; then
    # Moving by class test
    echo "Moving test frames by class..."
    sh $SCRIPTS_FOLDER/move_frames.sh $LOUD_FRAMES_TEST $LOUD_FRAMES_CLASS_TEST
    chmod 777 $LOUD_FRAMES_CLASS_TEST
else
    echo "Skipping moving test frames"
fi


#--- Moving features by class -----------------------------------------------------------

if [[ ! -d $LOUD_PCA_FEATURES_CLASS_TRAIN ]]; then
    # Moving by class train
    echo "Moving train features by class..."
    sh $SCRIPTS_FOLDER/move_frames.sh $LOUD_PCA_FEATURES_TRAIN $LOUD_PCA_FEATURES_CLASS_TRAIN
    chmod 777 $LOUD_PCA_FEATURES_CLASS_TRAIN
else
    echo "Skipping moving train features by class"
fi


if [[ ! -d $LOUD_PCA_FEATURES_CLASS_TEST ]]; then
    # Moving by class test
    echo "Moving test features by class..."
    sh $SCRIPTS_FOLDER/move_frames.sh $LOUD_PCA_FEATURES_TEST $LOUD_PCA_FEATURES_CLASS_TEST
    chmod 777 $LOUD_PCA_FEATURES_CLASS_TEST
else
    echo "Skipping moving test features by class"
fi


#--- Alignment --------------------------------------------------------------------------

if [[ ! -d $LOUD_ALIGNMENT_INDEXES_TRAIN ]]; then
    # Aligning train
    echo "Aligning train features by class..."
    mkdir -p $LOUD_ALIGNMENT_INDEXES_TRAIN
    sh $ALIGNMENT_SCRIPTS_FOLDER/run_align_deep_pca_gctw_train.sh $LOUD_PCA_FEATURES_CLASS_TRAIN $LOUD_ALIGNMENT_INDEXES_TRAIN
    chmod 777 $LOUD_ALIGNMENT_INDEXES_TRAIN
else
    echo "Skipping aligning train features by class"
fi


if [[ ! -d $LOUD_ALIGNMENT_INDEXES_TEST ]]; then
    # Aligning test
    echo "Aligning test features by class..."
    mkdir -p $LOUD_ALIGNMENT_INDEXES_TEST
    sh $ALIGNMENT_SCRIPTS_FOLDER/run_align_deep_pca_gctw_test_correct_class.sh $LOUD_PCA_FEATURES_CLASS_TRAIN $LOUD_PCA_FEATURES_CLASS_TEST $LOUD_ALIGNMENT_INDEXES_TEST
    chmod 777 $LOUD_ALIGNMENT_INDEXES_TEST
else
    echo "Skipping aligning test features by class"
fi


#--- Aligned frames extraction ----------------------------------------------------------

if [[ ! -d $LOUD_ALIGNED_FRAMES_TRAIN ]]; then
    # Extract aligned frames train
    echo "Extracting aligned train frames..."
    mkdir -p $LOUD_ALIGNED_FRAMES_TRAIN
    sh $PYTHON_SCRIPTS_FOLDER/extract_aligned_frames_from_indexes_interface.sh $LOUD_FRAMES_TRAIN $LOUD_ALIGNMENT_INDEXES_TRAIN $LOUD_ALIGNED_FRAMES_TRAIN
    chmod 777 $LOUD_ALIGNED_FRAMES_TRAIN
else
    echo "Skipping extracting aligned train frames"
fi


if [[ ! -d $LOUD_ALIGNED_FRAMES_TEST ]]; then
    # Extract aligned frames test
    echo "Extracting aligned test frames..."
    echo "WROOOOOOONG need to do it just for test sample"
    mkdir -p $LOUD_ALIGNED_FRAMES_TEST
    sh $PYTHON_SCRIPTS_FOLDER/extract_aligned_frames_from_indexes_interface.sh $LOUD_FRAMES_TEST $LOUD_ALIGNMENT_INDEXES_TEST $LOUD_ALIGNED_FRAMES_TEST
    chmod 777 $LOUD_ALIGNED_FRAMES_TEST
else
    echo "Skipping extracting aligned test frames"
fi


#--- Reduce fps and pad with silence ----------------------------------------------------

if [[ ! -d $TRAIN_FOLDER_REDUCED_FPS ]]; then
    #Create reduced fps train
    echo "Create reduced fps train..."
    mkdir -p $TRAIN_FOLDER_REDUCED_FPS
    python $PYTHON_SCRIPTS_FOLDER/reduce_fps_parallel.py $LOUD_ALIGNED_FRAMES_TRAIN $TRAIN_FOLDER_REDUCED_FPS $FPS
    python $PYTHON_SCRIPTS_FOLDER/replicate_last_frame_parallel.py $TRAIN_FOLDER_REDUCED_FPS $LENGTH
    chmod 777 $TRAIN_FOLDER_REDUCED_FPS
else
    echo "Skipping reduced fps train"
fi


if [[ ! -d $TEST_FOLDER_REDUCED_FPS ]]; then
    #Create reduced fps test
    echo "Create reduced fps test..."
    mkdir -p $TEST_FOLDER_REDUCED_FPS
    python $PYTHON_SCRIPTS_FOLDER/reduce_fps_parallel.py $LOUD_ALIGNED_FRAMES_TEST $TEST_FOLDER_REDUCED_FPS $FPS
    python $PYTHON_SCRIPTS_FOLDER/replicate_last_frame_parallel.py $TEST_FOLDER_REDUCED_FPS $LENGTH
    chmod 777 $TEST_FOLDER_REDUCED_FPS
else
    echo "Skipping reduced fps test"
fi


#--- Unify videos -----------------------------------------------------------------------
