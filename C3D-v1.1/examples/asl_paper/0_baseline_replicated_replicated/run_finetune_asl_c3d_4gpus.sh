SOLVER_FILE=$1
oarsub -p "gpu='YES' and gpucapability >= '5.2' and gpumem >= '10000'" -l /nodes=1/gpunum=4,walltime=12 -t besteffort -S "./finetuning_asl_4gpus.sh $SOLVER_FILE"
