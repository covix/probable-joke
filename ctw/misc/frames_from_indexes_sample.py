import sys
import os
import shutil
import numpy as np



def main():
    input_folder = sys.argv[1]
    alignment_file = sys.argv[2]
    output_folder = sys.argv[3]

    # matlab is 1-indexed
    print("INPUT_FOLDER: ",input_folder)
    aligned_idx = np.loadtxt(alignment_file, delimiter=',')
    video_folder=alignment_file[:-4]
    indexes=aligned_idx[:,-1]

    for frame_idx, frame in enumerate(indexes):
        print("INPUT_FOLDER: ",input_folder)
        print("Video_Folder: ",video_folder)
        print("JOIN: ", os.path.join(input_folder, video_folder))
        source = os.path.join(input_folder, video_folder,
                              "image_{:05d}.jpg".format(int(round(frame))))
        print("Source: ",source)
        dest = os.path.join(output_folder, video_folder,"image_{:05d}.jpg".format(frame_idx + 1))
        print("Destination: ",dest)
        shutil.copyfile(source, dest)

if __name__ == '__main__':
    main()
