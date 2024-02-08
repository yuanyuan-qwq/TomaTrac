import os
import shutil

source_folder = r"D:\\Desktop\\CNN dataset\\leafdata - CopyYOLO\\labels"
target_folder = r"D:\\Desktop\\test1"
file_names_to_match_dir = r"D:\\Desktop\\temp"

print("Files in source folder:")
print(os.listdir(source_folder))
print("Files to match:")
print(os.listdir(file_names_to_match_dir))

# Get list of file names from the directory
file_names_to_match = os.listdir(file_names_to_match_dir)

# Iterate through files in the source folder
for file_to_match in file_names_to_match:
    file_prefix, _ = os.path.splitext(file_to_match)
    # Iterate through files in the source folder
    for file_in_source in os.listdir(source_folder):
        source_prefix, _ = os.path.splitext(file_in_source)
        # Check if base filenames match
        if file_prefix == source_prefix:
            source_file_path = os.path.join(source_folder, file_in_source)
            destination_file_path = os.path.join(target_folder, file_in_source)
            # Copy the matching file from source_folder to the target folder
            shutil.copy(source_file_path, destination_file_path)
            print(f"File '{file_in_source}' copied successfully to '{target_folder}'")
            break  # Move to the next file to match
