# Duplicate File Finder

This is a simple Bash script that scans a given folder for **duplicate files** based on file size and **SHA-256 hash**. It helps you identify and optionally delete or move duplicate files to reclaim storage space or organize your system.

---

##  Features

- Detects duplicate files based on actual file content using SHA-256.
- Efficient: Only hashes files that are the same size (to avoid unnecessary computation).
- Handles filenames with spaces or special characters.
- Offers options to:
  - Delete duplicates
  - Move duplicates to a specified folder
  - Skip action

---

##  Requirements

- Bash shell
- Linux or macOS environment
- Tools used: `find`, `stat`, `sha256sum`, `awk`, `sort`, `rm`, `mv`

---

##  Usage

### 1. Make the script executable:

```bash
chmod +x find_duplicates.sh
### 2. Run the script with the folder you want to scan:
bash
Copy
Edit
./find_duplicates.sh /path/to/your/folder

