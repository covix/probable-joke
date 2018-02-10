INPUT_FOLDER=$1
OUTPUT_FOLDER=$2
FPS=$3

ENR_DIR=`dirname $0`
for f in `ls $INPUT_FOLDER`;
do
  mkdir -p $OUTPUT_FOLDER/$f
  python $ENR_DIR/reduce_fps_parallel.py $INPUT_FOLDER/$f $OUTPUT_FOLDER/$f $FPS
  # for i in `ls $INPUT_FOLDER/$f`;
  # do
  #   mkdir -p $OUTPUT_FOLDER/$f/$i
  #   python $ENR_DIR/reduce_fps_parallel.py $INPUT_FOLDER/$f/$i $OUTPUT_FOLDER/$f/$i 7.5
  # done
done
