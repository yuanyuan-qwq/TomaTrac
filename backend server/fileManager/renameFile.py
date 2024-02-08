import os

def rename_images(folder_path):
    if not os.path.exists(folder_path):
        print("Folder path does not exist.")
        return

    file_list = os.listdir(folder_path)
    image_files = [f for f in file_list if os.path.isfile(os.path.join(folder_path, f)) and f.lower().endswith(('.png', '.jpg', '.jpeg', '.gif'))]
    image_files.sort()  # Sort to ensure consistent renaming

    count = 1
    for old_name in image_files:
        file_ext = os.path.splitext(old_name)[1]
        new_name = f"noleaf_{count}{file_ext}"
        os.rename(os.path.join(folder_path, old_name), os.path.join(folder_path, new_name))
        count += 1

folder_path = "D:\\Desktop\\test"  # Replace this with your folder path
rename_images(folder_path)
