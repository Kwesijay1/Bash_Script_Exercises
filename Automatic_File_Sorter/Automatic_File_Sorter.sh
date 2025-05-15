#!/bin/bash
# This script organizes files in a folder based on their types by scanning a directory, identifying file extensions,
# and moving the files into appropriate subfolders like Documents, Images, and Videos.

# This function creates a folder if it doesn't exist
create_folder_if_not_exists() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# This function moves files to the appropriate folder
move_file_to_folder() {
    file=$1
    folder=$2
    mv "$file" "$folder"
    echo "Moved $file to $folder"
}

# Main directory to organize
TARGET_DIR=${1:-.}

# Define folders for each file type
DOCUMENTS="$TARGET_DIR/Documents"
IMAGES="$TARGET_DIR/Images"
VIDEOS="$TARGET_DIR/Videos"


# Create folders for file types
create_folder_if_not_exists "$DOCUMENTS"
create_folder_if_not_exists "$IMAGES"
create_folder_if_not_exists "$VIDEOS"


# This scans the directory and organizes files
for file in "$TARGET_DIR"/*; do
    # Skip directories and hidden files
    if [ -d "$file" ] || [[ $(basename "$file") == .* ]]; then
        continue
    fi

    # Get the file extension
    extension="${file##*.}"
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

    # Determine the file type and move accordingly using if-else statements
    if [[ "$extension" == "txt" || "$extension" == "pdf" || "$extension" == "doc" || "$extension" == "docx" || "$extension" == "xls" || "$extension" == "xlsx" || "$extension" == "ppt" || "$extension" == "pptx" ]]; then
        move_file_to_folder "$file" "$DOCUMENTS"
    elif [[ "$extension" == "jpg" || "$extension" == "jpeg" || "$extension" == "png" || "$extension" == "gif" || "$extension" == "bmp" || "$extension" == "tiff" || "$extension" == "svg" ]]; then
        move_file_to_folder "$file" "$IMAGES"
    elif [[ "$extension" == "mp4" || "$extension" == "mkv" || "$extension" == "avi" || "$extension" == "mov" || "$extension" == "wmv" || "$extension" == "flv" || "$extension" == "webm" ]]; then
        move_file_to_folder "$file" "$VIDEOS"
    else
        echo "Unknown file type: $file. Skipping..."
    fi
done

# Final message
echo "File organization complete. All files are sorted!"
