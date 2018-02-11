MODEL=$1
TEST_DATA_PATH="/data/sparks/share/asl/experiments/datasets/test/aligned_reduced_fps_loud_test_all_classes/"

echo "Testing started using model: " $MODEL

for CLASS in {01..17}
do
echo "Testing for class: " $CLASS
 ./replicate_and_run_class.sh $MODEL $TEST_DATA_PATH $CLASS
done

