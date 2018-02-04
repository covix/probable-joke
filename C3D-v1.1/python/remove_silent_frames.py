import os
import sys
import numpy as np

FEATURES_FILE = sys.argv[1]
OUTPUT_FOLDER = sys.argv[2]
FRAMES_OR_FEATURES = sys.argv[3]

# Usage: FRAMES_OR_FEATURES = 0 --> FRAMES
#        FRAMES_OR_FEATURES = 1 --> FEATURES


#FEATURES_FILE = "/media/schenock/01D1B41ED893D2C0/Projects/probable-joke/data/features/01-M-04-C-comp_features.csv" 


#========= LEFT PART =====================================================================

# Read correlation coeffs
features = np.loadtxt(FEATURES_FILE)
correlation_coeffs = np.corrcoef(features)

# Get last frame idx
first_frame = 0
last_frame = len(correlation_coeffs[0]) - 1

# Calculate middle value
middle_value = (len(correlation_coeffs[0]) - 1) / 2
index_middle = int(middle_value)

# Get correlations on the last part
correlation_with_last = correlation_coeffs[last_frame]
correlation_with_first = correlation_coeffs[first_frame]

left_part = correlation_with_first[:index_middle]

maxi = max(left_part)
mini = min(left_part)

threshold = (((maxi - mini) / 2) + mini)*1.1

if threshold >= 1:
    threshold = (((maxi - mini) / 2) + mini)


above = np.where(correlation_with_first > threshold)[0]
below = np.where(correlation_with_first < threshold)[0]

middle_left = np.where(left_part==mini)[0]

above_left = [frame for frame in above if frame < middle_left]



# ======== RIGHT PART ============================================================================

# Read correlation coeffs
features = np.loadtxt(FEATURES_FILE)
correlation_coeffs = np.corrcoef(features)

# Get last frame idx
first_frame = 0
last_frame = len(correlation_coeffs[0]) - 1


# Calculate middle value
middle_value = (len(correlation_coeffs[0]) - 1) / 2
index_middle = int(middle_value)

# Get correlations on the last part
correlation_with_last = correlation_coeffs[last_frame]
correlation_with_first = correlation_coeffs[first_frame]

right_part = correlation_with_last[index_middle:]
left_part = correlation_with_first[:index_middle]

maxi = max(right_part)
mini = min(right_part)

threshold = (((maxi - mini) / 2) + mini)*1.1

if threshold >= 1:
    threshold = (((maxi - mini) / 2) + mini)


above = np.where(correlation_with_last > threshold)[0]
below = np.where(correlation_with_last < threshold)[0]

middle_right = np.where(right_part==mini)[0]

above_right = [frame for frame in above if frame > middle_right + index_middle]



#========= OUTPUT ====================

from_frame = max(above_left) + 2
to_frame = min(above_right) - 2

if FRAMES_OR_FEATURES == 1:        
    # FEATURES

    # Create and save new features file
    new_features = features[from_frame:to_frame,]

    fname = FEATURES_FILE.split("/")[-1]

    np.savetxt(os.path.join(OUTPUT_FOLDER, fname), new_features)

    # Prints
    print("Features length: ", len(features))
    print("New features length: ", len(new_features))
    print("Cut video between: ", max(above_left) + 2, min(above_right) - 2)
else:
    # FRAMES
    print(from_frame, to_frame)



