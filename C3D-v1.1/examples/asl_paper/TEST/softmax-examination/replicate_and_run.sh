for i in `echo 01 04 21 42 43`;
do
    cp train_1_aligned_aligned.prototxt train_1_aligned_aligned_${i}.prototxt
    sed -i.sed_bak "s/test_c04/test_c${i}/g" train_1_aligned_aligned_${i}.prototxt
    sed -i.sed_bak "s/aligned_gctw_sample_test_reduced_fps_class\/04/aligned_gctw_sample_test_reduced_fps_class\/${i}/g" train_1_aligned_aligned_${i}.prototxt
    ./run_test_c3d_gpus.sh train_1_aligned_aligned_${i}.prototxt 1_aligned_aligned_2gpus_iter_492.caffemodel
done

rm *.sed_bak


