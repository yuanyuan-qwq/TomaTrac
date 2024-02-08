import os

folder_path = r'D:\\Programming\\Python\\WS2 backend\\YOLO1.1\\data\\temp'

# Iterate through each file in the specified directory
for filename in os.listdir(folder_path):
    if filename.endswith('.txt'):  # Process only text files (assuming label files have .txt extension)
        file_path = os.path.join(folder_path, filename)
        
        # Read the content of the label file
        with open(file_path, 'r') as file:
            lines = file.readlines()
        
        # Modify each line in the label file based on the rule
        modified_lines = []
        for line in lines:
            elements = line.strip().split()
            if elements:  # Check if the line is not empty
                current_class = int(elements[0])  # Get the current object class
                
                # Implement rule to change class labels (0 -> 1, 1 -> 2)
                if current_class == 0:
                    elements[0] = '1'
                elif current_class == 1:
                    elements[0] = '2'
                
                modified_lines.append(' '.join(elements) + '\n')
        
        # Write the modified content back to the label file
        with open(file_path, 'w') as file:
            file.writelines(modified_lines)
            
print("Object class values updated according to the rule.")
