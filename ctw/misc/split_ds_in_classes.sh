INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

N=`ls $INPUT_FOLDER | wc -l`

for i in `seq -w 1 $N`;
do
    mkdir -p ${OUTPUT_FOLDER}/${i}
    cp ${INPUT_FOLDER}/*-M-${i}* ${OUTPUT_FOLDER}/${i}
done
