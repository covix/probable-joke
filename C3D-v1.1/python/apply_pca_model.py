import os
import sys

import numpy as np
from sklearn.decomposition import PCA
from sklearn.externals import joblib


data_dir = sys.argv[1]
output_dir = sys.argv[2]
pca_filename = sys.argv[3]

feature_matrix_data = []
frame_indices = []
video_names = []
k = 0
for folder in os.listdir(data_dir):

    features_file_name = os.listdir(data_dir + '/' + folder)[0]

    feature_matrix = np.loadtxt(os.path.join(
        data_dir, folder, features_file_name), delimiter=' ').astype(np.float)

    frame_indices.append(feature_matrix.shape[0])

    video_names.append(features_file_name)

    feature_matrix_data.append(feature_matrix)
    k += 1
    print k, 'Number of frames:', feature_matrix.shape[0]


# Stack the features
feature_matrix_data = np.concatenate(feature_matrix_data)

print 'PCA Data shape: ', feature_matrix_data.shape

# Build pca model
pca = joblib.load(pca_filename)

pca_data_fit = pca.transform(feature_matrix_data)

print 'PCA finished. PCA data fit shape: ', pca_data_fit.shape

# Save PCA Features
k = 0
for idx, i in enumerate(frame_indices):
    np.savetxt(os.path.join(
        output_dir, video_names[idx]), pca_data_fit[k: k + i], delimiter=',')
    k += i

# Print statistics
print 'PCA explained variance ratio: ' + str(pca.explained_variance_ratio_)
print 'Explained variance: ' + str(sum(pca.explained_variance_ratio_))
print 'Shape after: ' + str(pca_data_fit.shape)
