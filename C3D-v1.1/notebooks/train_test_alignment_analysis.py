import sys
import os
import errno

import numpy as np

import matplotlib.pyplot as plt

# %matplotlib notebook


train_folder = '/Users/covix/Projects/probable-joke/ctw/misc/align_indexes_gctw_train'
test_folder = '/Users/covix/Projects/probable-joke/ctw/misc/04'

train_txt = sorted([os.path.join(train_folder, i)
                    for i in os.listdir(train_folder)])

test_samples_folder = sorted([os.path.join(test_folder, i)
                              for i in os.listdir(test_folder)])
test_samples = sorted([i for i in os.listdir(test_folder)])


def mkdir(directory):
    try:
        os.makedirs(directory)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise

plot_dir = 'plots/train_test_alignment_analysis'


for sample in range(len(test_samples_folder)):
    print test_samples[sample]
    test_sample_folder = test_samples_folder[sample]
    test_txt = sorted([os.path.join(test_sample_folder, i)
                       for i in os.listdir(test_sample_folder)])

    plot_dir_sample = os.path.join(plot_dir, test_samples[sample])
    mkdir(plot_dir_sample)

    for i in range(43):
        plt.figure()
        plt.title(os.path.basename(test_txt[i]))
        train = np.loadtxt(train_txt[i], delimiter=',').round().astype(np.int)
        test = np.loadtxt(test_txt[i], delimiter=',').round().astype(np.int)

        test = test[:, :-1]

        if train.shape[0] < test.shape[0]:
            print '\t', os.path.basename(train_txt[i]), train.shape
            print '\t', os.path.basename(test_txt[i]), test.shape
            print
            train2 = np.zeros_like(test)
            train2[:train.shape[0], :train.shape[1]] = train
            train = train2
        elif train.shape[0] > test.shape[0]:
            print '\t', os.path.basename(train_txt[i]), train.shape
            print '\t', os.path.basename(test_txt[i]), test.shape
            print
            test2 = np.zeros_like(train)
            test2[:test.shape[0], :test.shape[1]] = test
            test = test2

        plt.imshow(train - test, interpolation='none', cmap='Blues')
        plt.colorbar()
        fname = os.path.splitext(os.path.basename(test_txt[i]))[0]
        plt.savefig(os.path.join(plot_dir_sample, "{}.png".format(fname)))
        plt.close()

