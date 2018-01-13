SOLVER_FILE=$1
oarsub -p "gpu='YES' and gpucapability >= '5.2' and gpumem >= '10000'" -l /gpunum=1,walltime=12 -t besteffort -S "./finetuning_asl.sh $SOLVER_FILE"


# oarsub -I -p "gpu='YES'" -l /gpunum=1
