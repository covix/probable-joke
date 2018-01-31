INPUT_FOLDER=$1

for f in `ls $INPUT_FOLDER`;
do
  for i in `ls $INPUT_FOLDER/$f`;
  do
    python replicate_last_frame_parallel.py $INPUT_FOLDER/$f/$i 45
  done
done
