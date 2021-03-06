START=$(date +%s.%N)
echo 'Starting.. ' $START

python2 extract_features_pca.py '/home/schenock/caffe/data/_test_vid1' '/home/schenock/caffe/models/bvlc_googlenet/bvlc_googlenet.caffemodel' '/home/schenock/caffe/models/bvlc_googlenet/deploy.prototxt' '/home/schenock/caffe/data/ilsvrc12/ilsvrc_2012_mean.npy' '/home/schenock/caffe/examples/_pyfeatures_test/features' 'pool5/7x7_s1'


END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo 'Start: ' $START
echo 'End: ' $END
echo 'Total time: ' $DIFF
