import os
import sys
import re
import math

import numpy as np
from matplotlib import pyplot as plt

r = re.compile(r"Batch (\d+), prob = ([^\s]+)")


def _get_log_extension():
    return '.stderr'


def parse_log(log_file):
    probs = []

    with open(log_file) as f:
        last_class = None

        for l in f.readlines():
            matches = r.search(l)

            if matches:
                batch = int(matches.groups()[0])

                if last_class != batch:
                    last_class = batch
                    probs.append([])

                probs[last_class].append(float(matches.groups()[1]))

    # row x col = alignments x probabilities
    return np.asarray(probs)


if __name__ == '__main__':
    input_folder = sys.argv[1]

    log_files = [i for i in os.listdir(
        input_folder) if i.endswith(_get_log_extension())]

    for log_file in log_files:
        print "Parsing:", log_file
        m = parse_log(os.path.join(input_folder, log_file))

        plt.figure()
        plt.title(os.path.splitext(log_file)[0])
        plt.imshow(m, interpolation='none', cmap='Blues')
        plt.plot((0, m.shape[0] - 1), (0, m.shape[0] - 1))
        plt.savefig('plots/{}.png'.format(os.path.splitext(log_file)[0]))
        plt.close()

