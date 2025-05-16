#!/bin/bash
#bash script that provides functionality for backing up important files. It includes options for full 
#and partial backups, compression, and scheduling using cron.

# Set default configurations
SOURCE_DIR=""
DEST_DIR=""
BACKUP_TYPE="full"
COMPRESS=false
SCHEDULE=false

# This function display the usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -s <source_dir>   Specify the source directory to back up"
    echo "  -d <dest_dir>     Specify the destination directory for the backup"
    echo "  -t <type>         Specify backup type (full or partial)"
    echo "  -c                Enable compression of backup files"
    echo "  -h                Display this help message"
    echo "  -schedule <time>  Schedule backup using cron (e.g., 'hourly', 'daily', 'weekly', 'monthly')"
    exit 1
}

# This function performs the backup
backup() {
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    BACKUP_NAME="backup_$TIMESTAMP"
    DEST_PATH="$DEST_DIR/$BACKUP_NAME"

    echo "Starting backup..."
    echo "Source: $SOURCE_DIR"
    echo "Destination: $DEST_PATH"
    echo "Backup Type: $BACKUP_TYPE"
    
    if [ "$BACKUP_TYPE" == "full" ]; then
        cp -r "$SOURCE_DIR" "$DEST_PATH"
    elif [ "$BACKUP_TYPE" == "partial" ]; then
        echo "Enter files to back up (space-separated): "
        read -ra FILES
        mkdir -p "$DEST_PATH"
        for FILE in "${FILES[@]}"; do
            cp "$SOURCE_DIR/$FILE" "$DEST_PATH"
        done
    else
        echo "Invalid backup type specified."
        exit 1
    fi

    if [ "$COMPRESS" == true ]; then
        tar -czf "$DEST_PATH.tar.gz" -C "$DEST_DIR" "$BACKUP_NAME"
        rm -rf "$DEST_PATH"  # Remove uncompressed files
        echo "Backup compressed to $DEST_PATH.tar.gz"
    fi

    echo "Backup completed successfully."
}

# This function schedules the backup
schedule_backup() {
    case "$1" in
        hourly)
            CRON_TIME="1 * * * *"
            ;;
        daily)
            CRON_TIME="0 2 * * *"
            ;;
        weekly)
            CRON_TIME="0 2 * * 0"
            ;;
        monthly)
            CRON_TIME="0 2 1 * *"
            ;;
        *)
            echo "Invalid schedule option. Use 'hourly', 'daily', 'weekly', or 'monthly'."
            exit 1
            ;;
    esac

    SCRIPT_PATH=$(realpath $0)
    CRON_JOB="$CRON_TIME $SCRIPT_PATH -s $SOURCE_DIR -d $DEST_DIR -t $BACKUP_TYPE"
    if [ "$COMPRESS" == true ]; then
        CRON_JOB="$CRON_JOB -c"
    fi

    (crontab -l; echo "$CRON_JOB") | crontab -
    echo "Backup scheduled ($1) successfully."
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -s) SOURCE_DIR="$2"; shift ;;
        -d) DEST_DIR="$2"; shift ;;
        -t) BACKUP_TYPE="$2"; shift ;;
        -c) COMPRESS=true ;;
        -h) usage ;;
        -schedule) SCHEDULE="$2"; shift ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
    shift
done

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "Source and destination directories must be specified."
    usage
fi

if [ "$SCHEDULE" != false ]; then
    schedule_backup "$SCHEDULE"
else
    backup
fi
