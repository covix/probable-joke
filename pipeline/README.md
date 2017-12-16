# Pipeline Folder

This is the root folder for all the pipelines.

It would be great to have only working code (on both local and cluster), 
I don't ask you to open new branches (it would take too much time),
but push here only when the code is working in local and you want to test it on the cluster.

In every folder, there will be a different pipeline, once the first is completed,
you can create custom pipelines copying it to new ones, and personalising it as you wish.

## Pipeline Structure
The pipeline structure is the following:

* `run_pipeline.sh` is the highest level script, it's used to run the whole pipeline (or to resume it)
* `conf.sh.template` has to be copied to `conf.sh` and filled with all the environment dependant variables (check the cluster version)
* One folder for each step, containing:
  * `run_{step_name}.sh` which is the entry point for the higher level script
  * `{step}_interface.sh` which takes care of executing the current step 
  * `{step}.{extension}` which is the effective implementation of the current step
  * Code or libraries needed to execute the code

## Brief pipelines descriptions
### 1.0
This is the first developed pipeline, it extracts features from GoogLeNet on every frames,
which are then aligned and fed to AlexNet for finetuning.


