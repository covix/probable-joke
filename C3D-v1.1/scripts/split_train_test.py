"""
Split a caffe dataset file into train and test files
Usage: python split_train_test.py <input_file> <test_size> <outf>
"""

import os
import sys

from sklearn.model_selection import train_test_split


def main():
    input_file = sys.argv[1]
    test_size = float(sys.argv[2])
    outf = os.path.dirname(input_file)

    with open(input_file) as f:
        X = f.readlines()

    y = [i.split()[-1] for i in X]

    # TODO split on video level, not frame
    # TODO sort the results
    # TODO check if stratify really works
    X_train, X_test = train_test_split(
        X, test_size=test_size, stratify=y, random_state=42)

    with open(os.path.join(outf, 'train.txt'), 'w') as f:
        f.writelines(X_train)

    with open(os.path.join(outf, 'test.txt'), 'w') as f:
        f.writelines(X_test)


if __name__ == '__main__':
    main()
