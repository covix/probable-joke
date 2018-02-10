INPUT_FOLDER=$1

ENR_DIR=`dirname $0`

for f in `ls $INPUT_FOLDER`;
do
    python $ENR_DIR/replicate_last_frame_parallel.py $INPUT_FOLDER/$f/ 45
done
