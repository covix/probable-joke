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
    echo $c
    break
  fi
  ((c++))
done
