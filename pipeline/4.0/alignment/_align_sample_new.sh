TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train/pca_features_original_class_train/
TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/test/pca_features_original_class_test/
OUTPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/indexes_alignment_sample_new


for CLASS_FOLDER in `ls $TRAIN_FOLDER`
do
echo "Started alignment for class " $class_folder
echo
mkdir $OUTPUT_FOLDER/$CLASS_FOLDER

for TEST_SAMPLE in `ls $TEST_FOLDER/$CLASS_FOLDER`
do
echo "Sample " $TEST_SAMPLE " is being aligned.."
 ./run_align_deep_pca_gctw.sh $TRAIN_FOLDER $CLASS_FOLDER $TEST_FOLDER$CLASS_FOLDER/$TEST_SAMPLE $OUTPUT_FOLDER/$CLASS_FOLDER
done

done


