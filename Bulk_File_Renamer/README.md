# File Renaming Tool

This repository contains a simple bash script that allows users to rename multiple files in a directory using customizable patterns or rules. The script is designed to perform common file-renaming tasks such as adding prefixes, suffixes, counters, or dates to filenames.

## Features
- **Add Prefixes**: Add a custom prefix to filenames.
- **Add Suffixes**: Add a custom suffix to filenames.
- **Counters**: Append a numeric counter to filenames.
- **Dates**: Append the current date to filenames.
- **Simple to Use**: Minimal command-line arguments for ease of use.

## Usage

### Running the Script
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo-name/file-renaming-tool.git
   cd file-renaming-tool
   ```

2. Make the script executable:
   ```bash
   chmod +x simple_rename_files.sh
   ```

3. Run the script with the desired options:
   ```bash
   ./simple_rename_files.sh [options] [directory]
   ```

### Options
- `-p PREFIX`: Add a prefix to filenames.
- `-s SUFFIX`: Add a suffix to filenames.
- `-c`: Add a counter to filenames.
- `-d`: Add the current date to filenames.
- `-h`: Display usage instructions.

### Examples
1. **Add a prefix and a counter**:
   ```bash
   ./simple_rename_files.sh -p "new_" -c ./folder
   ```
   This renames files in the `./folder` directory by adding the prefix `new_` and a numeric counter.

2. **Add a suffix and the current date**:
   ```bash
   ./simple_rename_files.sh -s "_backup" -d ./folder
   ```
   This renames files in the `./folder` directory by adding the suffix `_backup` and appending the current date.

3. **Display help**:
   ```bash
   ./simple_rename_files.sh -h
   ```
   This displays the usage instructions for the script.

## Requirements
- Bash (Linux/MacOS or a compatible shell environment on Windows).


Enjoy renaming your files with ease!