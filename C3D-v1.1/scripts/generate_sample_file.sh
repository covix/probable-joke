# Generate a dataset text file suitable for Caffe
# Usage: ./generate_sample_file.sh <root_data_folder>

ROOTFOLDER=$1

for f in `ls $ROOTFOLDER/`
do
    nfiles=`ls -l $ROOTFOLDER/$f/ | wc -l`
    nfiles=$(($nfiles / 16))
    for i in $(seq 0 $(($nfiles - 1)))
    do
        echo $ROOTFOLDER/$f $(($i * 16 + 1)) `echo $f | cut -d'-' -f3`
    done
done
