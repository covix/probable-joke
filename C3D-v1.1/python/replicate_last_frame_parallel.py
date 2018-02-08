import os
import sys
import shutil
import multiprocessing


def copy(source, dest):
    shutil.copyfile(source, dest)


def main():
    if len(sys.argv) != 3:
        print "Usage: ./{} input_folder final".format(__file__)
        sys.exit(-1)

    input_folder = sys.argv[1]
    final_length = int(sys.argv[2])

    video_folders = sorted(os.listdir(input_folder))

    pool = multiprocessing.Pool(multiprocessing.cpu_count())
    print "Using a Pool of", multiprocessing.cpu_count(), "processes"

    for video_folder in video_folders:
        print video_folder
        frames = sorted(os.listdir(os.path.join(input_folder, video_folder)))
        source = os.path.join(input_folder, video_folder, frames[-1])

        # remaining frames
        for i in range(final_length - len(frames)):
            frame_name = "image_{:05d}.png".format(len(frames) + i + 1)
            dest = os.path.join(input_folder, video_folder, frame_name)
            pool.apply_async(copy, (source, dest))

    pool.close()
    pool.join()


if __name__ == '__main__':
    main()
