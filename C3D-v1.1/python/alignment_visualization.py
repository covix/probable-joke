import os
import sys
from matplotlib import pyplot as plt


original_folder = sys.argv[1]
aligned_folder = sys.argv[2]

original, aligned = {}, {}


def load_video_frames(input_folder):
    d = {}
    for i in os.listdir(input_folder):
        if os.path.isdir(os.path.join(input_folder, i)):
            print i
            d[i] = []
            files = sorted(os.listdir(os.path.join(input_folder, i)))

            for j in range(0, len(files)):
                fname = os.path.join(
                    input_folder, i, files[j])
                d[i].append(plt.imread(fname))

    return d


original = load_video_frames(original_folder)
aligned = load_video_frames(aligned_folder)


print "Original length => Aligned length"

original_length = 0
aligned_length = len(aligned.itervalues().next())

for k in original.keys():
    print '\t', len(original[k]), '=>', len(aligned[k]), k
    original_length = max(original_length, len(original[k]))


def plot_frames(d, length, step, title=''):
    fig = plt.figure()

    sp = 1
    for k in d.keys():
        for i in range(0, length / step * step, step):
            plt.subplot(3, length / step, sp)
            plt.axis('off')

            if i < len(d[k]):
                plt.imshow(d[k][i])
            sp += 1

    if title:
        plt.suptitle(title)
    return fig


step = 8

fig = plot_frames(original, original_length, step, "Original frames")
fig.set_size_inches(16.8, 3.75)
plt.savefig('../plots/alignment_visualization/original.png',
            bbox_inches='tight', dpi=300)

fig = plot_frames(aligned, aligned_length, step, "Aligned frames (GCTW)")
fig.set_size_inches(16.8, 3.75)
plt.savefig('../plots/alignment_visualization/aligned_gctw.png',
            bbox_inches='tight', dpi=300)

# plt.show()
print "Figure saved."
