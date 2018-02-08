INPUT_FOLDER=$1
ALIGN_IDX_FOLDER=$2
OUTPUT_FOLDER=$3

ENR_DIR=`dirname $0`

for CLASS in {01..43};
do
    echo "For sample class: " $CLASS
    echo
        for align_file in `ls $ALIGN_IDX_FOLDER/$CLASS`
        do
            SAMPLE_FOLDER=`echo $align_file | cut -d"." -f1`
            echo -e "\t\tCreating video for: " $align_file " in " $SAMPLE_FOLDER
            echo
            VID_INPUT_FOLDER=$INPUT_FOLDER/$SAMPLE_FOLDER
            VID_ALIGN_FILE=$ALIGN_IDX_FOLDER/$CLASS/$align_file
            VID_OUTPUT_FOLDER=$OUTPUT_FOLDER/$SAMPLE_FOLDER/
            echo -e "\t\tCreating output folder: " $VID_OUTPUT_FOLDER
            mkdir -p $VID_OUTPUT_FOLDER

            python $ENR_DIR/frames_from_indexes_sample.py $VID_INPUT_FOLDER $VID_ALIGN_FILE $VID_OUTPUT_FOLDER
        done
    done
