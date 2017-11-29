DATA=$1

for i in `ls $DATA/*-M-*`
do
	name=`basename $i | cut -d. -f 1`
	echo $name
	mkdir -p ./data/asl/$name
	ffmpeg -v 0 -i $i ./data/asl/$name/${name}_%d.png
done

