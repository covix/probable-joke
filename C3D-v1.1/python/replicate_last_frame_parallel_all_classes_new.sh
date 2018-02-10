INPUT_FOLDER=$1

for f in `ls $INPUT_FOLDER`;
do
    python replicate_last_frame_parallel.py $INPUT_FOLDER/$f/ 45
done
