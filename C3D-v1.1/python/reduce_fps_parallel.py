import os
import shutil
import sys
import multiprocessing


ACTUAL_FPS = 30


def copy(source, dest):
    shutil.copyfile(source, dest)


def main():
    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    fps = float(sys.argv[3])
    fps = int(ACTUAL_FPS / fps)

    if os.path.exists(output_folder):
        shutil.rmtree(output_folder)

    os.makedirs(output_folder)

    pool = multiprocessing.Pool(multiprocessing.cpu_count())
    print "Using a Pool of", multiprocessing.cpu_count(), "processes"

    X = sorted(next(os.walk(input_folder))[1])
    for x in X:
        print x
        folder = os.path.join(output_folder, x)
        os.mkdir(folder)

        Y = os.listdir(os.path.join(input_folder, x))
        Y.sort()
        for idx, i in enumerate(range(0, len(Y), fps)):
            y = Y[i]
            y = "image_{:05d}.jpg".format(idx + 1)
            source = os.path.join(input_folder, x, y)
            dest = os.path.join(folder, y)
            pool.apply_async(copy, (source, dest))

    pool.close()
    pool.join()


if __name__ == '__main__':
    main()
