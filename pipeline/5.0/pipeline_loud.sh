TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train/
TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/test/

ORIGINAL_FRAMES_TRAIN=$TRAIN_FOLDER/original_train
ORIGINAL_FEATURES_TRAIN=$TRAIN_FOLDER/deep_features_train
LOUD_FEATURES_TRAIN=$TRAIN_FOLDER/deep_features_loud_train
LOUD_FRAMES_TRAIN=$TRAIN_FOLDER/loud_train

ORIGINAL_FRAMES_TEST=$TEST_FOLDER/original_test
ORIGINAL_FEATURES_TEST=$TEST_FOLDER/deep_features_test
LOUD_FEATURES_TEST=$TEST_FOLDER/deep_features_loud_test
LOUD_FRAMES_TEST=$TRAIN_FOLDER/loud_test


#Create loud_train
./clean_silence_frames.sh $ORIGINAL_FRAMES_TRAIN $LOUD_FRAMES_TRAIN
#Create loud_train_features
./clean_silence_features.sh $ORIGINAL_FEATURES_TRAIN $LOUD_FEATURES_TRAIN

#Create loud_test
./clean_silence_frames.sh $ORIGINAL_FRAMES_TEST $LOUD_FRAMES_TEST
#Create loud_test_features
./clean_silence_features.sh $ORIGINAL_FEATURES_TEST $LOUD_FEATURES_TEST

#------------------------------------------------------------------------
#Alignment...
