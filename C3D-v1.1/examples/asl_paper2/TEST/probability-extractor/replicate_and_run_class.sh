WEIGHTS=$1
INPUT_FOLDER=$2
CLASS=$3


for i in `ls ${INPUT_FOLDER}/${CLASS}`;
do
    SAMPLE=${i}
    cp test_1_aligned_aligned_template.prototxt test_1_aligned_aligned_${SAMPLE}.prototxt
    sed -i.sed_bak "s/{CLASS}/${CLASS}/g" test_1_aligned_aligned_${SAMPLE}.prototxt
    sed -i.sed_bak "s/{SAMPLE}/${SAMPLE}/g" test_1_aligned_aligned_${SAMPLE}.prototxt
    ./run_test_c3d_gpus.sh test_1_aligned_aligned_${SAMPLE}.prototxt $WEIGHTS
done

#rm *.sed_bak


# Usage example ./replicate_and_run_class.sh 1_aligned_aligned_2gpus_iter_738.caffemodel ../../../../../../experiments/datasets/test/aligned_gctw_sample_test_all_classes_reduced_fps/ 04
