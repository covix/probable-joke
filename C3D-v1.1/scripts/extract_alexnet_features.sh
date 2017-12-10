# Used to extract features from every image in a folder using AlexNet. Run the script from caffe root folder.

FRAMESFOLDER=${1:-data/asl_frames}
WORKSPACEFOLDER=${2:-examples/_asl_features}
LAYER=${3:-fc7}

																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																													  
# Create workspace folder
echo 'Creating workspace folder..'
mkdir -p $WORKSPACEFOLDER

# Extract names from flattened images folder
echo 'Extracting file names..'
find `pwd`/$FRAMESFOLDER -type f -exec echo {} \; > $WORKSPACEFOLDER/names.txt

# Add 0 label next to each file (labes expected by caffe implementation)
sed "s/$/ 0/" $WORKSPACEFOLDER/names.txt > $WORKSPACEFOLDER/names_label.txt

# Uncomment if ./data/ilsvrc12/imagenet_mean.binaryproto doesn't exist. 
#./data/ilsvrc12/get_ilsvrc_aux.sh

# Copy net prototxt to workspace. To use different architecture modify imagenet_val.prototxt.
echo 'Copying net prototxt to workspace..'
cp examples/feature_extraction/imagenet_val.prototxt $WORKSPACEFOLDER

# Extract features
echo 'Extracting features..'
./build/tools/extract_features models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel $WORKSPACEFOLDER/imagenet_val.prototxt $LAYER $WORKSPACEFOLDER/features 10 leveldb

