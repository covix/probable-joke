import os
import sys
import numpy as np
import caffe
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from PIL import Image


N_COMP = 100

data_dir = sys.argv[1]
model_path = sys.argv[2]
deploy_prototxt_path = sys.argv[3]
imagemean_path = sys.argv[4]
output_dir = sys.argv[5]
layer = sys.argv[6]

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

# Real PCA
pca = PCA(n_components=N_COMP)

# Concatenated PCA Data
pca_data = []

# Preprocess and extract features from all files in a folder data_dir
for folder in os.listdir(data_dir):
    current_output_dir = output_dir + '/' + folder
    video_feature_matrix = []
    print 'In data folder: ' + folder + " , output folder: " + current_output_dir


    if not os.path.exists(current_output_dir):
            os.makedirs(current_output_dir)
    

    for image_file in os.listdir(data_dir + '/' + folder):
        print 'Processing image: ' + image_file
        # Load image
        img = caffe.io.load_image(data_dir + '/' + folder + '/' + image_file)
        
        # Preprocess the image using the transformer
        net.blobs['data'].data[...] = transformer.preprocess('data', img)
        
        # Feed forward the image in the net
        output = net.forward()

        # Create output file
        output_file = current_output_dir + '/' + image_file + '_features.txt'

        # Get the feature vector
        feature_vector = list(net.blobs[layer].data[0])

        # Print the shape of the data
        print 'Data shape: ' + str(net.blobs[layer].data[0].shape)

        # Flatten/Reshape
        feature_vector = np.ndarray.flatten(np.asarray(feature_vector))

        # Imaginary PCA 
        # feature_vector = feature_vector[:700]

        video_feature_matrix.append(feature_vector)

        # Append feature vector to big PCA matrix
        pca_data.append(feature_vector)

        # with open(output_file, 'w') as f:
        #     print net.blobs[layer].data.shape
            #print net.blobs[layer].data[0].shape
            

    # print video_feature_matrix

    # Concatenate for PCA purposes

    #TODO: Test purpose, delete
    video_feature_matrix_arr = np.asarray(video_feature_matrix)

    # for i in range(1, 3):
    #     video_feature_matrix_arr = np.concatenate((video_feature_matrix_arr, video_feature_matrix_arr))
    print '--------------------'    
   

# Apply PCA
pca_data_arr = np.asarray(pca_data)

print 'Shape before: ' + str(pca_data_arr.shape)

# Fit the model
pca_data_fit = pca.fit_transform(pca_data_arr)

# Print shit
print 'PCA explained variance ratio: ' +  str(pca.explained_variance_ratio_)
print 'Explained variance: ' + str(sum(pca.explained_variance_ratio_))
print 'Shape: ' + str(pca_data_fit.shape)
img = Image.fromarray(np.asarray(pca_data_fit))
img.show()

    # plt.imshow(np.asarray(video_feature_matrix), interpolation=None)
    # plt.gray()
    # plt.show()
    

    #         video_feature_matrix.append(net.blobs[layer].data[0][:10])       
    #         #np.savetxt(f, net.blobs[layer].data[0])
    #         np.savetxt(f, net.blobs[layer].data[0], fmt='%.4f', delimiter='\n')


    # #video_feature_matrix = np.asarray(video_feature_matrix)
    # print video_feature_matrix
    # # print 'Plotting video feature matrix:'
    # # print video_feature_matrix
    # # video_feature_matrix = np.asarray(video_feature_matrix)
    # # with open(output_file, 'w') as f:
    # #     np.savetxt(f, video_feature_matrix[:,:60])
    # plt.imshow(video_feature_matrix)
    # plt.gray()
    # plt.show()
    #print video_feature_matrix
    

    

        











