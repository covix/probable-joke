import os
import sys

from sklearn.model_selection import train_test_split


def main():
    if len(sys.argv) != 6:
        print "Usage: python {} input_file, test_size, block_size, train_out_file, test_out_file".format(os.path.basename(__file__))
        sys.exit(-1)

    input_file = sys.argv[1]
    test_size = float(sys.argv[2])
    block_size = int(sys.argv[3])
    train_out_file = sys.argv[4]
    test_out_file = sys.argv[5]

    times = int(180 / block_size) - 1
    stride = 1

    if((180 / float(block_size)) - (times + 1) != 0):
        print("Attention, block_size is not a multiple of 180 \nin this way you will ignore some frames!")

    outf = os.path.dirname(os.path.realpath(input_file))
    X = next(os.walk(input_file))[1]
    Y = []
    for f in X:
        for i in range(times):
            Y.append(f + " " + str(i * block_size + 1) + " " + stride)
    Y = map(lambda x: x + " " + x.split("-")[2], Y)
    X_train, X_test = train_test_split(Y, test_size=test_size)

    with open(os.path.join(outf, train_out_file), 'w') as f:
        f.write('\n'.join(X_train) + '\n')

    with open(os.path.join(outf, test_out_file), 'w') as f:
        f.write('\n'.join(X_train) + '\n')


if __name__ == '__main__':
    main()
