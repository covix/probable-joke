SOLVER_FILE=$1

oarsub -p "gpu='YES'" -l walltime=12 -S "./finetuning_asl.sh SOLVER_FILE=$1"


# oarsub -I -p "gpu='YES'" -l /gpunum=1
