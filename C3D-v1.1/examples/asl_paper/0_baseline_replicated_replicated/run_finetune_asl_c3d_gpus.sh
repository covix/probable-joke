SOLVER_FILE=$1
NUM_GPUS=$2

oarsub -p "gpu='YES' and gpucapability >= '5.2' and gpumem >= '10000'" -l /nodes=1/gpunum=$NUM_GPUS,walltime=12 -t besteffort -S "./finetuning_asl_gpus.sh $SOLVER_FILE $NUM_GPUS"
