cl = $1
dim = $2
TRAIN_FOLDER = $3
n=""
smallest=180
for f in `ls -d $TRAIN_FOLDER/*M-$cl-*`;
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
    echo $c
    break
  fi
  ((c++))
done
