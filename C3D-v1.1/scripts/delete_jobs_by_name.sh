name=$1
for a in`oarstat |grep $name cut -d" " -f1`;
do
  oardel $a
done
