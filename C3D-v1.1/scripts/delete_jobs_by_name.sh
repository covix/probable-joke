name=$1
a=`oarstat -u $name | cut -d" " -f1`
for i in $a;
do
  oardel $i
done
