import ffmpeg
import os
import sys
import subprocess
import datetime
import numpy as np
import shutil


# This function is spearated since it is slow.
def get_video_frame_count(fileloc):
    command = ['ffprobe',
               '-v', 'fatal',
               '-count_frames',
               '-show_entries', 'stream=nb_read_frames',
               '-of', 'default=noprint_wrappers=1:nokey=1',
               fileloc, '-sexagesimal']
    ffmpeg = subprocess.Popen(
        command, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    out, err = ffmpeg.communicate()
    if(err):
        print(err)
    out = out.split('\n')
    return out[0]


def extract_frames(output_folder, max_nframe):
    Y = sorted(os.listdir(output_folder))
    for idx, i in enumerate(Y):
        name = "/".join([output_folder, i])
        folder = "/".join(["frames_" + output_folder, i[:-4]])
        os.makedirs(folder)
        out = "/".join([folder, "%06d"]) + ".jpg"
        command = ['ffmpeg', '-i', name, out]
        ffmpeg = subprocess.Popen(
            command, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
        out, err = ffmpeg.communicate()
        X = sorted(os.listdir(folder))
        print("Length: ", len(X))
        if(len(X) < max_nframe):
            last = "/".join([folder, X[-1]])
            for c in range(max_nframe - len(X)):
                new = "/".join([folder, format(int(last[-10:-4]
                                                   ) + c + 1, "06") + ".jpg"])
                print(last, new)
                shutil.copyfile(last, new)
        if(len(X) > max_nframe):
            diff = len(X) - max_nframe
            print("DIFF: ", diff)
            for i in range(1, diff + 1):
                name = "/".join([folder, X[-i]])
                print("REMOVE: ", name)
                os.remove(name)


def main(input_folder, output_folder, max_nframe):
    Y = sorted(os.listdir(input_folder))
    n_frames = []
    for idx, i in enumerate(Y):
        name = "/".join([input_folder, i])
        nframe = get_video_frame_count(name)
        print(nframe)
        n_frames.append(get_video_frame_count(name))
    for idx, i in enumerate(Y):
        name = "/".join([input_folder, i])
        stream = ffmpeg.input(name)
        coeff = float(max_nframe) / float(n_frames[idx])
        print("COEFF: ", coeff)
        stream = ffmpeg.filter_(stream, 'setpts', str(coeff) + '*PTS')
        stream = ffmpeg.output(stream, "/".join([str(output_folder), str(i)]))
        ffmpeg.run(stream)
    extract_frames(output_folder, max_nframe)


if __name__ == "__main__":
    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    max_nframe = int(sys.argv[3])
    if os.path.exists(output_folder):
        shutil.rmtree(output_folder)
    if os.path.exists("frames_" + output_folder):
        shutil.rmtree("frames_" + output_folder)
    os.makedirs(output_folder)
    os.makedirs("frames_" + output_folder)
    main(input_folder, output_folder, max_nframe)

# Usage example:
# python delay.py ../../../data/mp4/ 180_delayed_mp4
