INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

for f in `ls $INPUT_FOLDER`;
do
  mkdir $OUTPUT_FOLDER/$f
  for i in $f;
    mkdir $OUTPUT_FOLDER/$f/$i
    echo python reduce_fps_parallel.py $INPUT_FOLDER $OUTPUT_FOLDER/$f/$i 7.5
done
done
