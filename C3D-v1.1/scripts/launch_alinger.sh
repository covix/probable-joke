TEST_FOLDER = $1
TRAIN_FODLER = $2
for f in `ls TEST_FOLDER`;
do
  dim= `ls $TEST_FOLDER/$f |wc -l`
  for cl in {01..43};
  do
    var="./select_closest_alignment.sh `$cl` `$dim`"
    n=$(eval $var)
    echo $n
  done
done
