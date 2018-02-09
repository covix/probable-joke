# Split video files into folder with frames
# Usage: ./create_dataset.sh <data_folder>

DATAFOLDER=$1

for i in `ls $DATAFOLDER/*-M-*`
do
    name=`basename $i | cut -d. -f 1`
    echo $name
    mkdir -p data/asl/$name
    ffmpeg -v 0 -i $i data/asl/$name/%06d.png
done
