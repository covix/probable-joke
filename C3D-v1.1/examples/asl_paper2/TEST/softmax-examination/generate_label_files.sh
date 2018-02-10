INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

FRAME_IDX=1
PAD=1
ONE=1

mkdir -p $OUTPUT_FOLDER

for CLASS_ID in {1..43}
do
    CLASS_ID_MINUS_1=$((CLASS_ID-ONE))
    LABEL_FILE="$OUTPUT_FOLDER/c_${CLASS_ID_PADDED}.txt"
    
    # pad the number 
    CLASS_ID_PADDED=`seq -f '%02g' $CLASS_ID $CLASS_ID`

    > $LABEL_FILE

    for SAMPLE in `ls $INPUT_FOLDER | grep "\-$CLASS_ID_PADDED"`
    do
        echo $SAMPLE $FRAME_IDX $CLASS_ID_MINUS_1 $PAD > $LABEL_FILE
    done
done

# Usage example: 
# ./generate_label_files.sh \
#     /data/sparks/share/asl/experiments/datasets/test/aligned_reduced_fps_loud_test \
#     /data/sparks/share/asl/experiments/datasets/test/aligned_reduced_fps_loud_test_class_labels
