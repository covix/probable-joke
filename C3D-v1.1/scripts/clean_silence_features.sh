FEATURES_FOLDER=$1
OUTPUT_FOLDER=$2
suffix=_features.csv

for f in `ls $FEATURES_FOLDER`;
do
  mkdir -p $OUTPUT_FOLDER/$f
  python remove_silent_frames.py $FEATURES_FOLDER/$f/$f$suffix $OUTPUT_FOLDER/$f 1
done

#Usage example
#./clean_silence_features.sh /data/sparks/share/asl/experiments/datasets/train/deep_features_train /data/sparks/share/asl/experiments/datasets/train/deep_features_loud_train