def main():
    input_folder = sys.argv[1]
    alignment_file = sys.argv[2]
    output_folder = sys.argv[3] if len(sys.argv) > 3 else input_folder

    # matlab is 1-indexed
    aligned_idx = np.loadtxt(alignment_file, delimiter=',')
    video_folder=alignment_file[:-4]
    indexes=aligned_idx[:,-1]
    for frame_idx, frame in enumerate(indexes):
        source = os.path.join(input_folder, video_folder,
                              "image_{:05d}.jpg".format(int(round(frame))))
        dest = os.path.join(output_folder, video_folder,"image_{:05d}.jpg".format(frame_idx + 1))
        shutil.copyfile(source, dest)

if __name__ == '__main__':
    main()
