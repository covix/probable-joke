import sys
import os
from sklearn.model_selection import train_test_split

def main():
    input_file = sys.argv[1]
    test_size = float(sys.argv[2])

    with open(input_file) as f:
        X = f.readlines()

    X_train, X_test = train_test_split(
        X, test_size=test_size, random_state=42)

    outf = 'examples/asl/'

    with open(os.path.join(outf, 'train.txt'), 'w') as f:
        f.writelines(X_train)

    with open(os.path.join(outf, 'test.txt'), 'w') as f:
        f.writelines(X_test)


if __name__ == '__main__':
    main()
