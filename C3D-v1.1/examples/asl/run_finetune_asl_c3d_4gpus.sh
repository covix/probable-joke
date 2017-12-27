oarsub -p "gpu='YES'" -l /nodes=1/gpunum=4,walltime=12 -S ./finetuning_asl_4gpus.sh 


# oarsub -I -p "gpu='YES'" -l /gpunum=1
