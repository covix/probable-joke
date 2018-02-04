
INPUT_FOLDER=$1
OUTPUT_FOLDER=$2


# Create output folder
echo "Creating output folder.."
mkdir $OUTPUT_FOLDER

# Moving by class
echo "Moving the frames by class.."
for class in {01..43};
do
mkdir $OUTPUT_FOLDER/$class
for f in `ls $INPUT_FOLDER/*M-$class-*`;
do
        cp -r $INPUT_FOLDER/$f $OUTPUT_FOLDER/$class
done
        echo "-----"
done
