# Bash Script Exercises Collection

This repository contains a suite of practical Bash scripting exercises, each designed to automate and simplify common file management and system administration tasks. The scripts are organized into directories by functionality, with each project featuring its own documentation and examples.

## **Requirements**
**Bash shell** (Linux, macOS, or Windows with WSL)

**Common Unix utilities** (e.g., find, stat, sha256sum, tar, openssl)

## Contents

- **[Automatic_File_Sorter](Automatic_File_Sorter/Automatic_File_Sorter.sh)**  
  Organizes files in a directory into subfolders (Documents, Images, Videos) based on file type.

- **[Bulk_File_Renamer](Bulk_File_Renamer/Bulk_File_Renamer.sh)**  
  Renames multiple files in bulk with options for prefixes, suffixes, counters, and dates.

- **[Disk_Space_Analyzer](Disk_Space_Analyzer/Disk_Space_Analyzer.sh)**  
  Analyzes disk usage and displays results in a tree-like structure with sorting and filtering.

- **[Duplicate_File_Finder](Duplicate_File_Finder/Duplicate_File_Finder.sh)**  
  Finds duplicate files by comparing file size and SHA-256 hash, with options to delete or move duplicates.

- **[File_Backup_System](File_Backup_System/File_Backup_System.sh)**  
  Backs up files or directories with support for full/partial backups, compression, and scheduling via cron.

- **[File_Encryption_Tool](File_Encryption_Tool/File_Encryption_Tool.sh)**  
  Encrypts and decrypts files securely using OpenSSL and password protection.

- **[File_Sync_Utility](File_Sync_Utility/File_Sync_Utility.sh)**  
  Synchronizes files between two directories, resolving conflicts and logging actions.

## Getting Started

 **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/bash-script-exercises.git
   cd bash-script-exercises

```
 **Make Scripts Executable**
```    
    chmod +x <script_name>.sh
```
 **Run a Script**
    
    ./<script_name>.sh [options]

Refer to each project's README.md for detailed usage instructions and examples.

## **Project Highlights**
**Automation:** Simplifies and automates repetitive file management and system administration tasks.

**Safety:** Includes safety features like confirmation prompts and logging to help prevent accidental data loss.

**Customization:** Scripts are easily adaptable to suit different workflows and project needs.

**Learning Opportunity:** Ideal for those looking to deepen their understanding of Bash scripting and Unix command-line tools.

Explore each folder for more information, examples, and customization tips. 


**Happy scripting!**