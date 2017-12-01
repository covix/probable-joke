DATAFOLDER=$1
OUTF=${2:-examples/asl}

mkdir -p $OUTF

echo "Splitting videos into frames..."
# scripts/create_dataset.sh $DATAFOLDER

echo "Creating dataset file..."
# scripts/generate_sample_file.sh data/asl > $OUTF/files.txt

echo "Splitting dataset into train/test"
python scripts/split_train_test.py $OUTF/files.txt 0.3 $OUTF
