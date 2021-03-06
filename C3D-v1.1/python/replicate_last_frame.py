import os
import sys
import shutil


def main():
    if len(sys.argv) != 3:
        print "Usage: ./{} input_folder final".format(__file__)
        sys.exit(-1)

    input_folder = sys.argv[1]
    final_length = int(sys.argv[2])

    video_folders = sorted(os.listdir(input_folder))
    for video_folder in video_folders:
        print video_folder
        frames = sorted(os.listdir(os.path.join(input_folder, video_folder)))
        source = os.path.join(input_folder, video_folder, frames[-1])

        # remaining frames
        for i in range(final_length - len(frames)):
            frame_name = "image_{:05d}.png".format(len(frames) + i + 1)
            dest = os.path.join(input_folder, video_folder, frame_name)
            shutil.copyfile(source, dest)


if __name__ == '__main__':
    main()
