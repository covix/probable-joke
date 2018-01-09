DATA_FOLDER=$1
ALIGNMENT_FOLDER=$2
OUTPUT_FOLDER=$3

N=`ls $DATA_FOLDER | wc -l`

for i in `seq -w 1 $N`;
do
    mkdir -p ${OUTPUT_FOLDER}/${i}
    echo $i
    python extract_align_frames.py $DATA_FOLDER/${i} ${ALIGNMENT_FOLDER}/*P_${i}.csv ${OUTPUT_FOLDER}/${i}
    echo
done
