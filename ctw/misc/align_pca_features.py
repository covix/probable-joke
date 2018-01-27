import os
import sys

import numpy as np


def main():
    input_folder = sys.argv[1]
    alignment_file = sys.argv[2]
    output_folder = sys.argv[3] if len(sys.argv) > 3 else input_folder

    # matlab is 1-indexed
    aligned_idx = np.loadtxt(alignment_file, delimiter=',').astype(np.int) - 1

    files = sorted(os.listdir(input_folder))
    assert len(files) == aligned_idx.shape[1], "lenght differs"

    for idx, f in enumerate(files):
        print idx, f
        loc = os.path.join(input_folder, f)
        pca_features = np.loadtxt(loc, delimiter=',')

        fname = os.path.splitext(f)[0] + "-aligned.csv"
        outf = os.path.join(output_folder, fname)

        aligned_features = pca_features[aligned_idx[:, idx]]
        np.savetxt(outf, aligned_features, delimiter=',')


if __name__ == '__main__':
    main()
