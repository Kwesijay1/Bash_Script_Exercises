# Automatic File Organizer

This script organizes files in a folder by scanning a directory, identifying file extensions, and moving the files into appropriate subfolders such as `Documents`, `Images`, `Videos`, and `Others`.

## How It Works
The script:
1. Scans the specified directory for files.
2. Identifies file types based on their extensions.
3. Moves files into categorized subfolders:
   - `Documents`: Includes files like `.txt`, `.pdf`, `.doc`, `.docx`, `.xls`, `.xlsx`, `.ppt`, `.pptx`.
   - `Images`: Includes files like `.jpg`, `.jpeg`, `.png`, `.gif`, `.bmp`, `.tiff`, `.svg`.
   - `Videos`: Includes files like `.mp4`, `.mkv`, `.avi`, `.mov`, `.wmv`, `.flv`, `.webm`.
   - `Others`: Any files that do not fit into the above categories.

## Requirements
- Bash shell (common in Linux and macOS).
- Permissions to create folders and move files in the target directory.

## Usage
1. Save the script as `organize_files.sh`.
2. Make it executable:
   ```bash
   chmod +x organize_files.sh
   ```
3. Run the script:
   ```bash
   ./organize_files.sh /path/to/directory
   ```
   If no directory is specified, the script will default to organizing files in the current directory (`.`).

## Features
- Automatically creates subfolders (`Documents`, `Images`, `Videos`, `Others`) if they do not already exist.
- Processes files while skipping directories and hidden files.
- Outputs logs indicating where each file was moved.

## Example
### Before Running the Script:
```
/example-folder
    file1.txt
    file2.pdf
    image1.jpg
    video1.mp4
    unknownfile.xyz
```

### Command:
```bash
./organize_files.sh /example-folder
```

### After Running the Script:
```
/example-folder
    /Documents
        file1.txt
        file2.pdf
    /Images
        image1.jpg
    /Videos
        video1.mp4
    /Others
        unknownfile.xyz
```

## Customization
You can extend the script to include additional file types by modifying the `if-else` conditions in the script. For example:
- Add new extensions to the `Documents`, `Images`, or `Videos` section.
- Add more custom folders as needed.


---
Happy organizing! 🎉