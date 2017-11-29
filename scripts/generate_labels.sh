BASEFOLDER=$1

for f in `ls BASEFOLDER/`
do
    nfiles=`ls -l $BASEFOLDER/$f/ | wc -l`
    nfiles=$((nfiles / 16))
    for i in seq(0 $(($nfiles - 1)))
    do
        echo $BASEFOLDER/$f $(($i * 16 + 1)) `echo $f | cut -d'-' -f3`
    done
done

