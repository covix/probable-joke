SOLVER_FILE=$1
oarsub -p "gpu='YES' and gpucapability >= '5.2' and gpumem >= '10000'" -l /nodes=1/gpunum=4,walltime=12 -t besteffor -S "./finetuning_asl_4gpus.sh $SOLVER_FILE"

# oarsub -p "gpu='YES'" -l /nodes=1/gpunum=4,walltime=12 -S "./finetuning_asl_4gpus.sh solver_r2_asl.prototxt"

# oarsub -I -p "gpu='YES'" -l /gpunum=1
