TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train
TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/test
SCRIPTS_FOLDER=/data/sparks/share/asl/experiments/datasets/scripts_data

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


#Create loud_train
echo "Create loud_train..."
sh $SCRIPTS_FOLDER/clean_silence_frames.sh $ORIGINAL_FEATURES_TRAIN $ORIGINAL_FRAMES_TRAIN $LOUD_FRAMES_TRAIN
echo "Create loud_train_features..."
#Create loud_train_features
sh $SCRIPTS_FOLDER/clean_silence_features.sh $ORIGINAL_FEATURES_TRAIN $LOUD_FEATURES_TRAIN

#Create loud_test
echo "Create loud_test..."
sh $SCRIPTS_FOLDER/clean_silence_frames.sh $ORIGINAL_FEATURES_TEST $ORIGINAL_FRAMES_TEST $LOUD_FRAMES_TEST
#Create loud_test_features
echo "Create loud_test_features..."
sh $SCRIPTS_FOLDER/clean_silence_features.sh $ORIGINAL_FEATURES_TEST $LOUD_FEATURES_TEST

chmod 777 $LOUD_FRAMES_TRAIN
chmod 777 $LOUD_FEATURES_TRAIN
chmod 777 $LOUD_FRAMES_TEST
chmod 777 $LOUD_FEATURES_TEST


#--- Moving -------------------------------------------------------------

# Moving by class
echo "Moving frames by class.."
sh $SCRIPTS_FOLDER/move_frames.sh $LOUD_FRAMES_TRAIN $LOUD_FRAMES_CLASS_TRAIN

# Moving by class test
echo "Moving frames by class test.."
sh $SCRIPTS_FOLDER/move_frames.sh $LOUD_FRAMES_TEST $LOUD_FRAMES_CLASS_TEST


#--- Alignment --------------------------------------------------------------
