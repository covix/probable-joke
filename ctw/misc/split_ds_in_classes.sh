INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

for i in `seq -w 1 43`;
do
    mkdir -p ${OUTPUT_FOLDER}/${i}
    cp ${INPUT_FOLDER}/*-M-${i}* ${OUTPUT_FOLDER}/${i}
done
