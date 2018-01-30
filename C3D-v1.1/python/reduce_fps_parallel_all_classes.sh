INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

for f in `ls $INPUT_FOLDER`;
mkdir $OUTPUT_FOLDER/$f
do
  for i in $f
  mkdir $OUTPUT_FOLDER/$f/$i
  echo python reduce_fps_parallel.py $INPUT_FOLDER $OUTPUT_FOLDER/$f/$i 7.5
done






















cl = $1
dim = $2

cl=01
dim=82
n=""
smallest=180
for f in `ls -d *M-$cl-*`;
do
  n=`ls $f | wc -l`
  val=`expr $dim - $n`
  v=${val#-}
  if [ $v -lt $smallest ]; then
        smallest=$v
  fi
done
c=1
for f in `ls -d *M-$cl-*`;
do
  n=`ls $f | wc -l`
  val=`expr $dim - $n`
  v=${val#-}
  if [ $v == $smallest ]; then
    echo $f $c
    break
  fi
  ((c++))
done




val=`expr sqrt($val * $val)`

cl=01
dim=73
for f in `ls -d *M-$cl-*`;
do
  n=`ls $f | wc -l`
  val=`expr $dim - $n`
  v=${val#-}
  echo $f $n $val $v
done


for i in `ls`;
do
class=`cut -d'-' -f3<<<$i`
echo $i 1 $class 1
done



"for i in $n;
do
  echo $i
done">
c=`cut -d'-' -f <<< $n`

if [ $n -gt $biggest ]; then
        biggest=$n
  fi

c=`cut -d'-' -f3 <<< $f`
echo $c
echo `ls original_train/$f/ | wc`


for i in {01..43};
do
    mkdir $i
    mv *M-$i-* $i/
done
