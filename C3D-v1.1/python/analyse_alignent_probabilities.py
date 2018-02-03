import os
import sys
import re
import math

from matplotlib import pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

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

    threshold = 0.8

    log_files = [i for i in os.listdir(
        input_folder) if i.endswith(_get_log_extension())]

    l = []
    diags = []
    for log_file in log_files:
        print "Parsing:", log_file
        m = parse_log(os.path.join(input_folder, log_file))
        diag = m.diagonal()
        diags.append(diag)
        y_pred = np.argmax(diag)

        print '\tIndex:', y_pred
        print '\tClass:', y_pred + 1
        print 'Probability:', diag[y_pred]
        print

        l.append(m[3, 3])

        sums = np.apply_along_axis(np.sum, 0, m)
        ratios = diag / sums
        ratios_th = ratios.copy()
        ratios_th[diag < threshold] = 0
        y_pred = np.argmax(ratios_th)

        plt.figure()
        plt.title("m")
        plt.imshow(m, interpolation='none', cmap='Blues')

        plt.figure()
        plt.subplot(511)
        plt.title("diag")
        plt.imshow(diag.reshape((1, 43)), interpolation='none', cmap='Blues')

        plt.subplot(512)
        plt.title("sums")
        plt.imshow(sums.reshape((1, 43)), interpolation='none', cmap='Blues')

        plt.subplot(513)
        plt.title("ratios")
        plt.imshow(ratios.reshape((1, 43)), interpolation='none', cmap='Blues')

        plt.subplot(514)
        plt.title("ratios_th")
        plt.imshow(ratios_th.reshape((1, 43)),
                   interpolation='none', cmap='Blues')

        plt.close()
        plt.close()

        print '\tIndex:', y_pred
        print '\tClass:', y_pred + 1
        print 'Probability:', diag[y_pred]
        print

        plt.figure()
        plt.title(os.path.splitext(log_file)[0])
        plt.imshow(m, interpolation='none', cmap='Blues')
        plt.plot((0, m.shape[0] - 1), (0, m.shape[0] - 1))
        plt.savefig('plots/{}.png'.format(os.path.splitext(log_file)[0]))
        plt.close()

        print
        print
