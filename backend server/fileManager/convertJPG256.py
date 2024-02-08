from PIL import Image
import os

def resize_images(folder_path, new_width=256, new_height=256):
    for filename in os.listdir(folder_path):
        if filename.endswith('.jpg'):  # Assuming the images are already in JPG format
            filepath = os.path.join(folder_path, filename)
            try:
                img = Image.open(filepath)
                resized_img = img.resize((new_width, new_height), Image.ANTIALIAS)
                resized_img.save(os.path.join(folder_path, f'resized_{filename}'))
                print(f"Resized {filename} to {new_width}x{new_height}")
            except Exception as e:
                print(f"Failed to resize {filename}: {e}")

# Replace 'folder_path' with the path to your folder containing the images
folder_path = 'D:\Programming\Python\WS2 backend\CNNStage\dataset\Flowering Stage'
resize_images(folder_path)
