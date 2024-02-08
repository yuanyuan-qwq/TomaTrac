from PIL import Image
import os

# Function to horizontally flip images in a folder and rename them
def horizontal_flip_and_rename(input_folder, output_folder):
    os.makedirs(output_folder, exist_ok=True)

    # Process each image file in the input folder
    for root, dirs, files in os.walk(input_folder):
        for index, file in enumerate(files):
            if file.endswith(".png") or file.endswith(".jpg") or file.endswith(".jpeg"):  # Add more image formats if needed
                image_path = os.path.join(root, file)

                # Open the image
                with Image.open(image_path) as img:
                    # Horizontal flip
                    flipped_img = img.transpose(Image.FLIP_LEFT_RIGHT)

                    # Define a new filename with the index as a prefix
                    new_filename = f"fli.pped_{index + 1}.png"  # Change the filename pattern as desired

                    # Save the flipped image with the new filename
                    output_filename = os.path.join(output_folder, new_filename)
                    flipped_img.save(output_filename)
                    print(f"Generated: {output_filename}")

input_images_folder = r"D:\Desktop\\temp"
output_images_folder = r"D:\Desktop\\temp"

# Perform horizontal flip and rename for images in the input folder and save them to the output folder
horizontal_flip_and_rename(input_images_folder, output_images_folder)

print("Horizontal flip and rename operation complete.")
