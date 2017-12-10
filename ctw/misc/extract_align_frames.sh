DATA_FOLDER=$1
ALIGNMENT_FOLDER=$2
OUTPUT_FOLDER=$3

for i in `seq -w 1 14`;
do
    mkdir -p ${OUTPUT_FOLDER}/${i}
    echo $i
    python extract_align_frames.py $DATA_FOLDER/${i} ${ALIGNMENT_FOLDER}/aliGtw${i}P.csv ${OUTPUT_FOLDER}/${i}
    echo
done
