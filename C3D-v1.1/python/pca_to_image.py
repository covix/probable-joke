import math
import os
import sys

import numpy as np

from PIL import Image


def quantize_image(image, bit_rate=3, verbose=False, min_=-1, max_=-1):
    if max_ == -1:
        max_ = image.max()

    if min_ == -1:
        min_ = image.max()

    number_of_levels = int(math.pow(2, bit_rate))

    domain_range = max_ - min_
    quantization_step = domain_range / number_of_levels

    # here we use code_book and code_book_l, the former contains the real
    # representative values, while the latter contains the edges of the
    # quantization levels
    code_book = [image.min() + quantization_step / 2]
    code_book_l = [image.min()]

    for i in range(1, number_of_levels):
        code_book.append(code_book[-1] + quantization_step)
        code_book_l.append(code_book_l[-1] + quantization_step)

        if code_book[-1] + quantization_step / 2 >= image.max():
            break

    # np.digitize return an index `i`, such that bins[i-1] <= x < bins[i].
    # Faster than quantizing iterating over all the values, given that
    # numpy is written in C++
    quantized_sb = np.digitize(
        image, code_book_l, right=True).clip(1, len(code_book)) - 1

    return quantized_sb


if __name__ == '__main__':
    input_folder = sys.argv[1]
    output_folder = sys.argv[2]

    print "Reading frames..."
    min_, max_, num_frames = [], [], []
    k = 0
    for f in os.listdir(input_folder):
        pca_matrix = np.loadtxt(os.path.join(input_folder, f), delimiter=',')
        min_.append(pca_matrix.min())
        max_.append(pca_matrix.max())
        num_frames.append(pca_matrix.shape[0])

        if k % 100 == 0:
            print "\t", k
        k += 1

    print

    min_ = min(min_)
    max_ = max(max_)
    max_num_frames = max(num_frames)

    print "Min:", min_
    print "Max:", max_
    print "Max number of frames:", max_num_frames
    print

    print "Saving frames..."
    k = 0
    for f in os.listdir(input_folder):
        pca_matrix = np.loadtxt(os.path.join(input_folder, f), delimiter=',')

        # we force min_ and max_ to quantize on the distribution
        # considering the whole dataset
        quantized_pca_matrix = quantize_image(
            pca_matrix, bit_rate=8, min_=min_, max_=max_)

        zeros = np.zeros(
            (max_num_frames - quantized_pca_matrix.shape[0],
             quantized_pca_matrix.shape[1])
        )
        quantized_pca_matrix = np.append(quantized_pca_matrix, zeros, axis=0)

        fname = os.path.splitext(os.path.basename(f))[0]
        im = Image.fromarray(quantized_pca_matrix.astype(np.uint8))
        im.save(os.path.join(output_folder, '{}.png'.format(fname)))

        if k % 100 == 0:
            print "\t", k
        k += 1
