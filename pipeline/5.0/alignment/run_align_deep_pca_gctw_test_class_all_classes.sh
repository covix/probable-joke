TRAIN_FOLDER=$1
TEST_FOLDER=$2
OUTPUT_FOLDER=$3
CLASS_ID=$4
MAX_PROCESSES_RUNNING=${5:-6}
WAIT_ID=$6  # empty is ok!, otherwise just put a job you want to w8 for

# pad the number
CLASS_ID=`seq -f '%02g' $CLASS_ID $CLASS_ID`
ID=
WAIT_ID=
ENR_CODE=`dirname $0`  # Current folder, containing supporting scripts and files


echo "Started alignment for class " $CLASS_ID
echo
mkdir -p $OUTPUT_FOLDER/$CLASS_ID

for TEST_SAMPLE in `ls $TEST_FOLDER/$CLASS_ID`
do
    TEST_SAMPLE_ID=${TEST_SAMPLE%_*}
    for CLASS in {01..43}
    do        
        OUTPUT_FILE="$OUTPUT_FOLDER/$CLASS_ID/$TEST_SAMPLE_ID/$CLASS/${TEST_SAMPLE}"
        if [ ! -f $OUTPUT_FILE ]; then
            echo "Sample $TEST_SAMPLE is being aligned to class $CLASS"
            mkdir -p $OUTPUT_FOLDER/$CLASS_ID/$TEST_SAMPLE_ID/$CLASS

            CMD="${ENR_CODE}/run_align_deep_pca_gctw_test.sh $TRAIN_FOLDER/ $CLASS $TEST_FOLDER/$CLASS_ID/$TEST_SAMPLE $OUTPUT_FOLDER/$CLASS_ID/$TEST_SAMPLE_ID/$CLASS $WAIT_ID"
            ID="--anterior=$($CMD):$ID"

            count=${ID//[^:]}

            if [ ${#count} = $MAX_PROCESSES_RUNNING ]; then
                WAIT_ID=$ID
                ID=
            fi
        fi
        
    done
done

echo $ID


# alignment_indexes_loud_test_all_classes/01/$TEST_SAMPLE/01/01-M-01-C-comp_features.csv

# Usage example
# ./run_align_deep_pca_gctw_test_class_all_classes.sh \
    # /data/sparks/share/asl/experiments/datasets/train/pca_features_loud_class_train/ \
    # /data/sparks/share/asl/experiments/datasets/test/pca_features_loud_class_test/ \
    # /data/sparks/share/asl/experiments/datasets/test/alignment_indexes_loud_test_all_classes \
    # 04 \
    # 10 # if possible


# ./run_align_deep_pca_gctw_test_class_all_classes.sh /data/sparks/share/asl/experiments/datasets/train/pca_features_original_class_train/ data/sparks/share/asl/experiments/datasets/test/pca_features_original_class_test/ data/sparks/share/asl/experiments/datasets/test/alignment_indexes_original_test_all_classes \
#     04 \
#     10 # if possible
