import os
import sys

from sklearn.model_selection import train_test_split


def main():
    if len(sys.argv) != 6:
        print "Usage: python {} input_folder, test_size, block_size, train_out_file, test_out_file".format(os.path.basename(__file__))
        sys.exit(-1)

    input_folder = sys.argv[1]
    test_size = int(sys.argv[2])
    block_size = int(sys.argv[3])
    train_out_file = sys.argv[4]
    test_out_file = sys.argv[5]

    outf = os.path.dirname(os.path.realpath(input_folder))
    X = os.listdir(input_folder)
    Y = []

    video_length = len(os.listdir(os.path.join(input_folder, X[0])))

    stride = 1
    times = int(video_length / block_size)

    if((video_length / float(block_size)) - (times + 1) != 0):
        print "Attention, block_size is not a multiple of", video_length
        print "in this way you will ignore some frames!"
    labels=[]
    for f in X:
        for i in range(times):
            # Y.append(f + " " + str(i * block_size + 1))
            frame = str(i * block_size + 1)
            label = f.split("-")[2]
            labels.append(label)
            Y.append("{filename} {frame} {label} {stride}".format(
                filename=f, frame=frame, label=label, stride=stride))

    # Y = map(lambda x: x + " " + x.split("-")[2] + " " + str(stride), Y)
    X_train, X_test = train_test_split(Y, test_size=test_size,stratify=labels)


    with open(train_out_file, 'w') as f:
        f.write('\n'.join(X_train) + '\n')

    with open(test_out_file, 'w') as f:
        f.write('\n'.join(X_test) + '\n')


if __name__ == '__main__':
    main()

#Usage example
#python split_train_test_RC3D.py ../aligned_video_pimw 0.3 40 train1.txt test1.txt
