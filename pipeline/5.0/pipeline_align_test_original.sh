# Aligns all videos from input folder to class class_id and saves them in
# OUTPUT_FOLDER. Afterwards they are reduced by FPS_RATE

source /data/sparks/share/asl/asl/bin/activate

INPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/original_test
ALIGN_IDX_FOLDER=/data/sparks/share/asl/experiments/datasets/test/alignment_indexes_original_test_all_classes
OUTPUT_FOLDER=/data/sparks/share/asl/experiments/datasets/test/aligned_frames_original_test_all_classes/
OUTPUT_FOLDER_FPS=/data/sparks/share/asl/experiments/datasets/test/aligned_reduced_fps_original_test_all_classes/
CLASS_ID=$1
FPS_RATE=7.5
FINAL_LENGTH=45

PYTHON_SCRIPT_FOLDER=/data/sparks/share/asl/probable-joke/C3D-v1.1/python/

# Align all test videos to class class_id
$PYTHON_SCRIPT_FOLDER/frames_from_indexes_test_sample_all_classes.sh \
  $INPUT_FOLDER \
  $ALIGN_IDX_FOLDER \
  $OUTPUT_FOLDER \
  $CLASS_ID

# reduce fps and save OUTPUT_FOLDER_FPS
$PYTHON_SCRIPT_FOLDER/reduce_fps_parallel_all_classes_new.sh \
  $OUTPUT_FOLDER $OUTPUT_FOLDER_FPS \
  $FPS_RATE

# make videos same length
$PYTHON_SCRIPT_FOLDER/replicate_last_frame_parallel_all_classes_new.sh \
  $OUTPUT_FOLDER_FPS \
  $FINAL_LENGTH
