FEATURES_FOLDER=$1
VIDEO_FOLDER=$2
OUTPUT_FOLDER=$3
suffix=_features.csv
REMOVE_SILENT_FRAME_PATH=/data/sparks/share/asl/experiments/datasets/scripts_data/remove_silent_frames.py
for f in `ls $FEATURES_FOLDER`;
do
  echo video $f
  indexes=`python $REMOVE_SILENT_FRAME_PATH $FEATURES_FOLDER/$f/$f$suffix $OUTPUT_FOLDER/$f 0`
  indexes=${indexes:1:-1}
  ind1=`cut -d"," -f1 <<<$indexes`
  ind2=`cut -d"," -f2 <<<$indexes`
  start=`cut -d" " -f1<<<$ind1`
  end=`cut -d" " -f2<<<$ind2`
  frames=`ls $VIDEO_FOLDER/$f`
  frames=`cut -d" " -f$start-$end <<<$frames`
  mkdir -p $OUTPUT_FOLDER/$f
  a=1
  for i in $frames;
  do
    new=$(printf "image_%05d.jpg" "$a")
    cp $VIDEO_FOLDER/$f/$i $OUTPUT_FOLDER/$f/$new
    let a=a+1
  done
done



#Usage example
#./clean_silence_frame.sh /data/sparks/share/asl/experiments/datasets/train/dee$
#/data/sparks/share/asl/experiments/datasets/train/original_train /data/sparks/$
