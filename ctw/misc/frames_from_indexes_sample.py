import sys
import os
import shutil
import numpy as np


def main():
    input_folder = sys.argv[1]
    alignment_file = sys.argv[2]
    output_folder = sys.argv[3]

    # matlab is 1-indexed
    # print("PYTHON: Input folder: ", input_folder)
    # print("PYTHON: Alignment file: ", alignment_file)
    # print("PYTHON: Output folder: ", output_folder)

    aligned_idx = np.loadtxt(alignment_file, delimiter=',')

    indexes = aligned_idx[:, -1]

    for frame_idx, frame in enumerate(indexes):

        source = os.path.join(
            input_folder, "image_{:05d}.jpg".format(int(round(frame))))
        print("Source: ", source)

        dest = os.path.join(
            output_folder, "image_{:05d}.jpg".format(frame_idx + 1))
        print("Destination: ", dest)

        shutil.copyfile(source, dest)

if __name__ == '__main__':
    main()
