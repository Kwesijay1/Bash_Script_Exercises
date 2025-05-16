# File Backup System

## Overview

This is a Bash script that provides functionality for backing up important files. It supports full and partial backups, file compression, and backup scheduling using `cron`. The script is designed to make file backups easy, efficient, and automated.

## Features

- **Full Backup**: Copies all files and subdirectories from the source directory to the destination.
- **Partial Backup**: Allows you to select specific files to back up.
- **Compression**: Optionally compresses the backup files into a `.tar.gz` archive to save space.
- **Scheduling**: Automates backups using `cron`; supports hourly, daily, weekly, and monthly schedules.

## Prerequisites

- Linux or macOS with Bash installed.
- `tar` utility for compression.
- `cron` for scheduling backups.

## Usage

```bash
Usage: ./File_Backup_System.sh [OPTIONS]
Options:
  -s <source_dir>   Specify the source directory to back up.
  -d <dest_dir>     Specify the destination directory for the backup.
  -t <type>         Specify backup type (`full` or `partial`).
  -c                Enable compression of backup files.
  -h                Display this help message.
  -schedule <time>  Schedule backup using `cron` (e.g., 'hourly', 'daily', 'weekly', 'monthly').
```

### Examples

#### Full Backup
```bash
./File_Backup_System.sh -s /path/to/source -d /path/to/destination -t full
```

#### Partial Backup
```bash
./File_Backup_System.sh -s /path/to/source -d /path/to/destination -t partial
```
When prompted, enter the names of the files (space-separated) that you want to back up.

#### Backup with Compression
```bash
./File_Backup_System.sh -s /path/to/source -d /path/to/destination -t full -c
```

#### Schedule a Daily Backup
```bash
./File_Backup_System.sh -s /path/to/source -d /path/to/destination -t full -schedule daily
```

## How It Works

1. **Backup Process**: The script copies files from the source directory to the destination directory. For partial backups, you can specify the files to back up.
2. **Compression**: If the `-c` option is used, the backup files are compressed into a `.tar.gz` archive.
3. **Scheduling**: The script adds a `cron` job for automated backups at the specified interval (hourly, daily, weekly, or monthly).

## Troubleshooting

- Ensure that the source and destination directories exist and are accessible.
- If scheduling does not work, check your `cron` configuration using `crontab -l`.
- For compression, ensure the `tar` utility is installed and available in your system.

## Notes

- Scheduled backups require `cron` to be properly configured on your system.
- The script removes uncompressed backups after creating a compressed `.tar.gz` file to save space.
