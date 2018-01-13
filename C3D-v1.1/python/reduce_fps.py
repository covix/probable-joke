"""
remember to push from the cluster (cit. polimi teacher)
"""

import os
import shutil
import sys

#import imageio
#import matplotlib.pyplot as plt
#import visvis as vv

ACTUAL_FPS = 30


def create_video3(input_folder):
    for f in os.listdir(input_folder):
        outf = "video" + f[:-4] + ".mp4"
        with imageio.get_writer(outf) as writer:
            for frame in os.listdir(input_folder):
                print(os.path.join(input_folder, frame))
                im = imageio.imread(os.path.join(input_folder, frame))
                plt.imshow(im)
                plt.show(im)
                writer.append_data(im)


def create_video2(input_folder):
    writer = imageio.get_writer('cockatoo_gray.avi', fps=10)
    for file in sorted(os.listdir(input_folder)):
        im = imageio.imread("/".join([input_folder, file]))
        plt.imshow(im)
        writer.append_data(im[:, :, :])
    writer.close()
    plt.imshow(im)
    # plt.show()


def create_video(input_folder):
    import cv2
    for file in os.listdir(input_folder):
        img = cv2.imread("/".join([input_folder, file]))
        height, width, layers = img.shape

    video = cv2.VideoWriter('video.avi', -1, 1, (width, height))
    for file in os.listdir(input_folder):
        img = cv2.imread(file)
        video.write(img)
    video.release()


def main():
    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    fps = float(sys.argv[3])
    fps = int(ACTUAL_FPS / fps)
    if os.path.exists(os.path.dirname(output_folder)):
        shutil.rmtree(output_folder)
    os.makedirs(output_folder)
    X = next(os.walk(input_folder))[1]
    for x in X:
        folder = "/".join([output_folder, x, ""])
        os.makedirs(os.path.dirname(folder))
        Y = os.listdir("/".join([input_folder, x, ""]))
        Y.sort()
        for idx, i in enumerate(range(0, len(Y), fps)):
            y = Y[i]
            y = format(idx, "06") + ".jpg"
            source = "/".join([input_folder, x, y])
            dest = folder + y
            shutil.copyfile(source, dest)
        # create_video2(folder)


if __name__ == '__main__':
    main()
