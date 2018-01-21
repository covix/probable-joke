INPUT_FOLDER=$1
OUTPUT_FOLDER=$2

for i in {01..43};
do
    echo $i
    mkdir -p ${OUTPUT_FOLDER}/${i}/
    cp ${INPUT_FOLDER}/*-M-${i}-* ${OUTPUT_FOLDER}/${i}/    
done



