# Used to extract and store features for each video in a folder. Run the script from caffe root folder.

WORKSPACEFOLDER='examples/_asl_features/'


for folder in data/asl/*/
do
echo 'Folder with name: ' $folder

# Creating the subworkspace folder here (for frames of 1 video)
echo 'Workfolder will be created with name:'
subfolder=$WORKSPACEFOLDER$(basename $folder)
echo $subfolder
mkdir -p subfolder

# Extract features
echo 'Extracting features for video:' $folder
./scripts/extract_alexnet_features.sh $folder $subfolder

echo
echo 
done

