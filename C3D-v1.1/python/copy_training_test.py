import os
import sys
import shutil

def copy(data_folder,list,dest):
    for file in list:
	copyfile(data_folder + "/" + file, dest + "/" + file)

def main(data_folder,train_file,train_folder):
    #Read Train file labels
    with open(train_file) as f:
        X = f.readlines()
    train_files = [i.split(" ")[0]  for i in X]
    input_train_files = [os.path.join(data_folder,i)  for i in train_files]
    output_train_files = [os.path.join(train_folder,i)  for i in train_files]
    for i in range(len(train_files)):
    	shutil.copytree(input_train_files[i],output_train_files[i])
    
if __name__=="__main__":
    data_folder = sys.argv[1]
    train_file = sys.argv[2]
    train_folder = sys.argv[3]
    main(data_folder,train_file,train_folder)

#Usage example
#python copy_training_test.py ../aligned_video_pimw train1.txt ../asl_train
