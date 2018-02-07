
INPUT_FOLDER=$1
OUTPUT_FOLDER=$2


# Create output folder
echo "Creating output folder.."
mkdir -p $OUTPUT_FOLDER

# Moving by class
echo "Moving the frames by class.."
for class in {01..43};
    do
    mkdir -p $OUTPUT_FOLDER/$class
    for f in `ls -d $INPUT_FOLDER/*M-$class-*`;
    do
        cp -r $f $OUTPUT_FOLDER/$class
    done
    echo "-----"
done
