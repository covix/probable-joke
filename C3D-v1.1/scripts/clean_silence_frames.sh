FEATURES_FOLDER=$1
VIDEO_FOLDER=$2
OUTPUT_FOLDER=$3
for f in `ls $FEATURES_FOLDER`;
do
  indexes=`python script.py $FEATURES_FOLDER/$f/$f_features.csv`
  echo start=`cut -d" " -f1<<<$indexes`
  echo end=`cut -d" " -f2<<<$indexes`
  echo frames=`ls $VIDEO_FOLDER/$f`
  echo frames=`cut -d" " -f$start,$end <<<$frames`
  echo mkdir -p $OUTPUT_FOLDER/$f
  echo cp $frames $OUTPUT_FOLDER/$f
done


#Usage example
#./clean_silence_frame /data/sparks/share/asl/experiments/datasets/train/deep_features_train /data/sparks/share/asl/experiments/datasets/train/original_train /data/sparks/share/asl/experiments/datasets/train/loud_train
