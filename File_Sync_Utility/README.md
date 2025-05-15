# File Sync Utility

## Description
The **File Sync Utility** is a Bash script to synchronize files between two directories. It ensures two-way synchronization, automatically resolving conflicts based on the last-modified timestamp of files. This utility is lightweight, efficient, and ideal for keeping directories consistent.

## Features
- **Two-Way Synchronization**: Ensures both directories have the latest versions of all files.
- **Conflict Resolution**: Automatically resolves conflicts by using the most recently modified file.
- **Logging**: Records all synchronization actions in a log file (`sync.log`).

## How It Works
1. Files are synchronized between the two directories.
2. If a file exists in both directories, the script compares their last-modified timestamps and updates the older file with the newer version.
3. Files missing in one directory are copied from the other.
4. Deleted files are removed from both directories to maintain consistency.

## Usage

### Prerequisites
- A Bash shell (Linux, macOS, or Windows with WSL).
- Basic understanding of shell scripting and directory paths.

### Steps
1. Clone the repository or download the script.
2. Make the script executable:
    ```bash
    chmod +x file_sync_utility.sh
    ```
3. Run the script with two directory paths as arguments:
    ```bash
    ./file_sync_utility.sh /path/to/dir1 /path/to/dir2
    ```

### Example
#### Directory Contents Before Sync:
- **Directory 1**:  
  ```
  file1.txt (Last modified: 2025-05-10)
  file2.txt (Last modified: 2025-05-12)
  ```

- **Directory 2**:  
  ```
  file1.txt (Last modified: 2025-05-11)
  file3.txt (Last modified: 2025-05-13)
  ```

#### Running the Script:
```bash
./file_sync_utility.sh /home/user/folder1 /home/user/folder2
```

#### Directory Contents After Sync:
- **Directory 1** and **Directory 2**:  
  ```
  file1.txt (Last modified: 2025-05-11)
  file2.txt (Last modified: 2025-05-12)
  file3.txt (Last modified: 2025-05-13)
  ```

### Log File
A `sync.log` file is created in the same directory as the script to record all synchronization actions.

## Script Overview
```bash
#!/bin/bash

# Directories to synchronize
DIR1=$1
DIR2=$2

# Log file to record actions
LOG_FILE="sync.log"

# Function to log messages
log_message() { ... }

# Function to sync files from source to destination
sync_files() { ... }

# Function to remove deleted files from destination
remove_deleted_files() { ... }

# Main script logic
log_message "Starting synchronization..."
sync_files "$DIR1" "$DIR2"
sync_files "$DIR2" "$DIR1"
remove_deleted_files "$DIR1" "$DIR2"
remove_deleted_files "$DIR2" "$DIR1"
log_message "Synchronization complete"
```

## Notes
- Ensure both directories exist before running the script.
- Be cautious when syncing directories with sensitive or important data—backups are recommended.



## Contributions
Contributions, issues, and feature requests are welcome! Feel free to open a pull request or an issue on this repository.

