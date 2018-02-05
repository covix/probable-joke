# Used to extract features from every image in a folder using AlexNet. Run the script from caffe root folder.

FRAMESFOLDER=${1:-data/asl_frames}
FEATUREFOLDER=${2:-examples/_asl_features}
LAYER=${3:-fc7}

# source ... put into config the root caffe folder (locally)

# Create workspace folder
echo 'Creating features folder..'
mkdir -p $FEATUREFOLDER

# Extract names from flattened images folder
echo 'Extracting file names..'
find `pwd`/$FRAMESFOLDER -type f -exec echo {} \; > $FEATUREFOLDER/names.txt

# Add 0 label next to each file (labes expected by caffe implementation)
sed "s/$/ 0/" $FEATUREFOLDER/names.txt > $FEATUREFOLDER/names_label.txt

# Uncomment if ./data/ilsvrc12/imagenet_mean.binaryproto doesn't exist.
#./data/ilsvrc12/get_ilsvrc_aux.sh

# Copy net prototxt to workspace. To use different architecture modify imagenet_val.prototxt.
echo 'Copying net prototxt to workspace..'
cp examples/feature_extraction/imagenet_val.prototxt $FEATUREFOLDER

# Extract features
# TODO How to get to caffe root folder?
echo 'Extracting features..'
./build/tools/extract_features models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel $FEATUREFOLDER/imagenet_val.prototxt $LAYER $FEATUREFOLDER/features 10 leveldb
