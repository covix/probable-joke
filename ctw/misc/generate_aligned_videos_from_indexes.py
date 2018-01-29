import sys
import os

import imageio
import numpy as np


def main():
    input_folder = sys.argv[1]
    alignment_file = sys.argv[2]
    output_folder = sys.argv[3] if len(sys.argv) > 3 else input_folder

    # matlab is 1-indexed
    aligned_idx = np.loadtxt(alignment_file, delimiter=',')

    files = sorted(os.listdir(input_folder))
    assert len(files) == aligned_idx.shape[1], "lenght differs"

    for idx, f in enumerate(files):
        print idx, f
        loc = os.path.join(input_folder, f)
        with imageio.get_reader(loc, 'ffmpeg') as reader:
            fname = "-aligned".join(os.path.splitext(f))
            outf = os.path.join(output_folder, fname)
            with imageio.get_writer(outf) as writer:
                for frame in aligned_idx[:, idx]:
                    im = reader.get_data(int(round(frame)) - 1)
                    writer.append_data(im)

if __name__ == '__main__':
    main()
