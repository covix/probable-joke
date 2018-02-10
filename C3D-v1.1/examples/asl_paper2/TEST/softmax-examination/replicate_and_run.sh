WEIGHTS=$1
$CLASSES_TO_TEST="01 04 24 42 43"

for i in `echo $CLASSES_TO_TEST`;
do
    cp train_1_aligned_aligned.prototxt train_1_aligned_aligned_${i}.prototxt
    sed -i.sed_bak "s/{CLASS}/${i}/g" train_1_aligned_aligned_${i}.prototxt
    # sed -i.sed_bak "s/aligned_gctw_sample_test_reduced_fps_class\/04/aligned_gctw_sample_test_reduced_fps_class\/${i}/g" train_1_aligned_aligned_${i}.prototxt
    ./run_test_c3d_gpus.sh train_1_aligned_aligned_${i}.prototxt $WEIGHTS
done

rm *.sed_bak
