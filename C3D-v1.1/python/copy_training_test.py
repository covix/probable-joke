import os
import sys
import shutil

def copy(data_folder,list,dest):
    for file in list:
	copyfile(data_folder + "/" + file, dest + "/" + file)

def main(data_folder,train_file,train_folder,test_file,test_folder):
    #Read Train file labels
    with open(train_file) as f:
        X = f.readlines()
    train_files = [i.split(" ")[0]  for i in X]
    input_train_files = [os.path.join(data_folder,i)  for i in train_files]
    output_train_files = [os.path.join(train_folder,i)  for i in train_files]
    for i in range(len(train_files)):
    	shutil.copytree(input_train_files[i],output_train_files[i])
    
     #Read Test file labels
    with open(test_file) as f:
        Y = f.readlines()
    test_files = [i.split(" ")[0]  for i in Y]
    input_test_files = [os.path.join(data_folder,i)  for i in test_files]
    output_test_files = [os.path.join(test_folder,i)  for i in test_files]
    for i in range(len(test_files)):
    	shutil.copytree(input_test_files[i],output_test_files[i])

if __name__=="__main__":
    data_folder = sys.argv[1]
    train_file = sys.argv[2]
    train_folder = sys.argv[3]
    test_file = sys.argv[4]
    test_folder = sys.argv[5]
    main(data_folder,train_file,train_folder,test_file,test_folder)

#Usage example
#python copy_training_test.py ../aligned_video_pimw/ train1.txt ../asl_train test1.txt ../asl_test
