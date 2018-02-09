# TRAIN_FOLDER=/data/sparks/share/asl/experiments/datasets/train/pca_features_original_class_train/
# TEST_FOLDER=/data/sparks/share/asl/experiments/datasets/test/pca_features_original_class_test/
# OUTPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/indexes_alignment_sample_new
# CLASS_ID=04

TRAIN_FOLDER=$1
TEST_FOLDER=$2
OUTPUT_FOLDER=$3
CLASS_ID=$4


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

    for CLASS in {01..43}
    do
        echo "Sample $TEST_SAMPLE is being aligned to class $CLASS"
        mkdir -p $OUTPUT_FOLDER/$CLASS_ID/$CLASS

        CMD="${ENR_CODE}/run_align_deep_pca_gctw_test.sh $TRAIN_FOLDER/$CLASS $CLASS_ID $TEST_FOLDER/$CLASS_ID/$TEST_SAMPLE $OUTPUT_FOLDER/$CLASS_ID/$CLASS $WAIT_ID"
        ID="--anterior=$($CMD):$ID"

        count=${ID//[^:]}

        if [ ${#count} = 6 ]; then 
            WAIT_ID=$ID
            ID=
        fi

    done
done
