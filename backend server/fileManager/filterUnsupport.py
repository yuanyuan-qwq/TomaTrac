import os
import tensorflow as tf

IMAGE_SIZE = 256
BATCH_SIZE = 32  # Define your batch size

def load_and_preprocess_image(file_path):
    try:
        # Load the image, decode it, and resize it to the desired size
        image = tf.io.read_file(file_path)
        image = tf.image.decode_jpeg(image, channels=3)  # Modify based on your image format
        image = tf.image.resize(image, [IMAGE_SIZE, IMAGE_SIZE])
        # Normalize the pixel values to be in the range [0, 1]
        image = tf.cast(image, tf.float32) / 255.0
        return image
    except Exception as e:
        print(f"Error processing image {file_path}: {e}")
        # If an error occurs (unsupported image), delete the file
        os.remove(file_path)
        print(f"Unsupported image deleted: {file_path}")
        return None

# Directory containing the images
data_dir = r'D:\\Desktop\\test'  # Use 'r' before the path for raw string

# Get a list of all image files in the directory
file_list = [os.path.join(data_dir, file) for file in os.listdir(data_dir)
             if file.lower().endswith(('.png', '.jpg', '.jpeg', '.bmp'))]

# Remove None values (caused by unsuccessful image reads)
file_list = [file for file in file_list if load_and_preprocess_image(file) is not None]

# Create a TensorFlow dataset from the file paths and map the preprocessing function
dataset = tf.data.Dataset.from_tensor_slices(file_list)
dataset = dataset.map(load_and_preprocess_image, num_parallel_calls=tf.data.AUTOTUNE)
dataset = dataset.shuffle(buffer_size=len(file_list)).batch(BATCH_SIZE)

for image_batch in dataset.take(1):
    print(image_batch.shape)
