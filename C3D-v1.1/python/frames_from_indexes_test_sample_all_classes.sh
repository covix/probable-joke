INPUT_FOLDER=$1
ALIGN_IDX_FOLDER=$2
OUTPUT_FOLDER=$3
CLASS_ID=$4  # 04


# INPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/loud_test
# ALIGN_IDX_FOLDER=/data/sparks/share/asl/experiments/datasets/test/alignment_indexes_loud_test_all_classes
# OUTPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/aligned_frames_loud_test_all_classes/
# CLASS_ID=04


# pad the number
CLASS_ID=`seq -f '%02g' $CLASS_ID $CLASS_ID`

ENR_DIR=`dirname $0`


for SAMPLE_FOLDER in `ls $ALIGN_IDX_FOLDER/$CLASS_ID`
do
    echo $SAMPLE_FOLDER

    for CLASS in {01..43}
    do
        # SAMPLE_FOLDER=`echo $align_file | cut -d"." -f1`
        # SAMPLE_FOLDER=`echo $align_file | cut -d"_" -f1`

        ALIGN_FILE=`ls $ALIGN_IDX_FOLDER/$CLASS_ID/$SAMPLE_FOLDER/$CLASS`

        VID_INPUT_FOLDER=$INPUT_FOLDER/$SAMPLE_FOLDER
        VID_ALIGN_FILE=$ALIGN_IDX_FOLDER/$CLASS_ID/$SAMPLE_FOLDER/$CLASS/$ALIGN_FILE
        VID_OUTPUT_FOLDER=$OUTPUT_FOLDER/$SAMPLE_FOLDER/$CLASS

        mkdir -p $VID_OUTPUT_FOLDER

        python $ENR_DIR/frames_from_indexes_sample.py $VID_INPUT_FOLDER $VID_ALIGN_FILE $VID_OUTPUT_FOLDER

    done
done


# for CLASS in {01..43};
# do
#     echo "For sample class: " $CLASS
#     echo
#     for align_file in `ls $ALIGN_IDX_FOLDER/$CLASS`
#     do
#         SAMPLE_FOLDER=`echo $align_file | cut -d"." -f1`
#         SAMPLE_FOLDER=`echo $align_file | cut -d"_" -f1`
#         echo -e "\t\tCreating video for: " $align_file " in " $SAMPLE_FOLDER
#         echo

#         VID_INPUT_FOLDER=$INPUT_FOLDER/$SAMPLE_FOLDER
#         VID_ALIGN_FILE=$ALIGN_IDX_FOLDER/$CLASS/$align_file
#         VID_OUTPUT_FOLDER=$OUTPUT_FOLDER/$SAMPLE_FOLDER/

#         echo -e "\t\tCreating output folder: " $VID_OUTPUT_FOLDER
#         mkdir -p $VID_OUTPUT_FOLDER

#         python $ENR_DIR/frames_from_indexes_sample.py $VID_INPUT_FOLDER $VID_ALIGN_FILE $VID_OUTPUT_FOLDER
#     done
# done


# Usage example
# ./frames_from_indexes_test_sample_all_classes.sh \
#     /data/sparks/share/asl/experiments/datasets/test/loud_test \
#     /data/sparks/share/asl/experiments/datasets/test/alignment_indexes_loud_test_all_classes \
#     /data/sparks/share/asl/experiments/datasets/test/aligned_frames_loud_test_all_classes/ \
#     04
