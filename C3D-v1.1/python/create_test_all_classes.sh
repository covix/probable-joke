INPUT_FOLDER=$1
ONE=1

for i in `ls $INPUT_FOLDER`;
do
  echo "FOR CLASS " $i
  for f in `ls $INPUT_FOLDER/$i`;
  do
    echo "FOR SAMPLE " $f
    file=$INPUT_FOLDER/$i/$f.txt
    touch $file
    for c in `ls $INPUT_FOLDER/$i/$f`;
    do
      class=$i
      echo $c 1 $((class-ONE)) 1 >> $file
    done
  done
done
