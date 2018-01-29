INPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/original_test
ALIGN_IDX_FOLDER=/data/sparks/share/asl/experiments/datasets/test/indexes_alignment_sample_all_classes/04
OUTPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/aligned_gctw_sample_test_all_classes/04


for SAMPLE_FOLDER in `ls $ALIGN_IDX_FOLDER`
do
echo "SH: For sample folder: " $SAMPLE_FOLDER
echo


for align_file in `ls $ALIGN_IDX_FOLDER/$SAMPLE_FOLDER`
do
echo "SH: Creating video for: " $alignment_file " in " $SAMPLE_FOLDER
echo

al=${align_file::-4}
echo "AL " $al

VID_INPUT_FOLDER=$INPUT_FOLDER/$SAMPLE_FOLDER
VID_ALIGN_FILE=$ALIGN_IDX_FOLDER/$SAMPLE_FOLDER/$align_file
VID_OUTPUT_FOLDER=$OUTPUT_FOLDER/$SAMPLE_FOLDER/$al

echo "SH: Creating output folder: " $VID_OUTPUT_FOLDER
mkdir -p $VID_OUTPUT_FOLDER


python frames_from_indexes_sample.py $VID_INPUT_FOLDER $VID_ALIGN_FILE $VID_OUTPUT_FOLDER
echo "--------------------------------"
done 
done
