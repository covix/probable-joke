MODEL_FILE=$1
WEIGHTS=$2
NUM_GPUS=1

JOB_NAME=${MODEL_FILE%.*}

oarsub -p "gpu='YES' and gpucapability >= '5.2' and gpumem >= '10000'" \
    -l /nodes=1/gpunum=$NUM_GPUS,walltime=12 \
    -t besteffort \
    -n $JOB_NAME \
    -S "./testing_asl_gpus.sh $MODEL_FILE $WEIGHTS"
