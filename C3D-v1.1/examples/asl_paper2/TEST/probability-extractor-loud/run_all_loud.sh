MODEL=$1
TEST_DATA_PATH="/data/sparks/share/asl/experiments/datasets/test/aligned_reduced_fps_loud_test_all_classes/"

echo "Testing started using model: " $MODEL

for CLASS in {01..43}
do
echo "Testing for class: " $CLASS
echo ./replicate_and_run_class.sh 1_aligned_aligned_2gpus_iter_738.caffemodel $TEST_DATA_PATH $CLASS
done

