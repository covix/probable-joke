import os
import sys
import numpy as np
import caffe
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from PIL import Image


data_dir = sys.argv[1]
model_path = sys.argv[2]
deploy_prototxt_path = sys.argv[3]
imagemean_path = sys.argv[4]
output_dir = sys.argv[5]
layer = sys.argv[6]

N_COMP = sys.argv[7] if len(sys.argv) == 8 else 100
N_COMP = int(N_COMP)

# Create caffe Net object
net = caffe.Net(deploy_prototxt_path, model_path, caffe.TEST)

# Check if layer exists
if layer not in net.blobs:
    raise TypeError("Invalid layer name. Layer doesn't exist in net definition: " + layer)

# Create preprocessor
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
transformer.set_mean('data', np.load(imagemean_path).mean(1).mean(1))
transformer.set_transpose('data', (2,0,1))
transformer.set_raw_scale('data', 255.0)

# Reshape the data blob to accept AlexNet dimensions
net.blobs['data'].reshape(1,3,224,224)

# PCA model
pca = PCA(n_components=N_COMP)

# Concatenated PCA Data
pca_data = []

num_frames_array = []

# Preprocess and extract features from all files in a folder data_dir
for folder in os.listdir(data_dir):
    current_output_dir = output_dir + '/' + folder
    video_feature_matrix = []
    print 'In data folder: ' + folder + " , output folder: " + current_output_dir

    if not os.path.exists(current_output_dir):
             os.makedirs(current_output_dir)

    num_frames = 0
    for image_file in sorted(os.listdir(data_dir + '/' + folder)):

        num_frames = num_frames + 1

        print 'Processing image: ' + image_file
        # Load image
        img = caffe.io.load_image(data_dir + '/' + folder + '/' + image_file)

        # Preprocess the image using the transformer
        net.blobs['data'].data[...] = transformer.preprocess('data', img)

        # Feed forward the image in the net
        output = net.forward()

        # Get the feature vector
        feature_vector = list(net.blobs[layer].data[0])

        # Print the shape of the data
        print 'Data shape: ' + str(net.blobs[layer].data[0].shape)

        # Flatten/Reshape
        feature_vector = np.ndarray.flatten(np.asarray(feature_vector))

        # Add feature vector to video feature matrix
        video_feature_matrix.append(feature_vector)

        # Append feature vector to big PCA matrix
        pca_data.append(feature_vector)

    # Save number of frames of current video
    num_frames_array.append(num_frames)

    # Create output file
    output_file = current_output_dir + '/' + folder + '_features.txt'

    # Save video feature matrix in file
    with open(output_file, 'w') as f:
        np.savetxt(f, video_feature_matrix)
    print '-------------------------------'


# Apply PCA
pca_data_arr = np.asarray(pca_data)

print 'Shape before: ' + str(pca_data_arr.shape)

# Fit the model
pca_data_fit = pca.fit_transform(pca_data_arr)

# Save PCA pre-processed data
pca_data_fit_file = output_dir + '/' + '_pca_data_fit.txt'
num_frames_file = output_dir + '/' + 'num_frames.txt'

with open(pca_data_fit_file, 'w') as f:
    np.savetxt(f, pca_data_fit)

with open(num_frames_file, 'w') as f:
    np.savetxt(f, num_frames_array)

# Print statistics
print 'PCA explained variance ratio: ' +  str(pca.explained_variance_ratio_)
print 'Explained variance: ' + str(sum(pca.explained_variance_ratio_))
print 'Shape after: ' + str(pca_data_fit.shape)
plt.imshow(pca_data_fit, interpolation='nearest')
plt.gray()
plt.show()
