########################################################################
#
# funtion use to process the sample data of eye
#
# Implemented in Python 3.5
#
########################################################################

from dataset import load_cached
import os

########################################################################

# Directory where you want to download and save the data-set.
# Set this before you start calling any of the functions below.
data_dir = "data/eyes"

########################################################################
# Various constants for the size of the images.
# Use these constants in your own program.

# Width and height of each image.
img_width = 256
img_height = 256

# Number of channels in each image, 1 channel in grey scale
num_channels = 1

# Length of an image when flattened to a 1-dim array.
img_size_flat = img_height * img_width * num_channels

# Number of classes.
num_classes = 2

def load():
    """
    Load the eye data-set into memory.


    :return:
        A DataSet-object for the eye data-set.
    """

    # Path for the cache-file.
    cache_path = os.path.join(data_dir, "eye.pkl")

    # If the DataSet-object already exists in a cache-file
    # then load it, otherwise create a new object and save
    # it to the cache-file so it can be loaded the next time.
    dataset = load_cached(cache_path=cache_path,
                          in_dir=data_dir)

    return dataset

########################################################################

if __name__ == '__main__':

    # Load the data-set.
    dataset = load()

    # Get the file-paths for the images and their associated class-numbers
    # and class-labels. This is for the training-set.
    image_paths_train, cls_train, labels_train = dataset.get_training_set()

    # Get the file-paths for the images and their associated class-numbers
    # and class-labels. This is for the test-set.
    image_paths_test, cls_test, labels_test = dataset.get_test_set()

    # Check if the training-set looks OK.

    # Print some of the file-paths for the training-set.
    for path in image_paths_train[0:5]:
        print(path)

    # Print the associated class-numbers.
    print(cls_train[0:5])

    # Print the class-numbers as one-hot encoded arrays.
    print(labels_train[0:5])

    # Check if the test-set looks OK.

    # Print some of the file-paths for the test-set.
    for path in image_paths_test[0:5]:
        print(path)

    # Print the associated class-numbers.
    print(cls_test[0:5])

    # Print the class-numbers as one-hot encoded arrays.
    print(labels_test[0:5])

########################################################################


