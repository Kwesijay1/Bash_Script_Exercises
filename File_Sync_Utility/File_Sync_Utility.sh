#!/bin/bash
#This bash script is designed to synchronize files between two directories seamlessly.

# Directories to synchronize
DIR1=$1
DIR2=$2

# Log file to record actions
LOG_FILE="sync.log"

# This function log messages to the log file with a timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# This function sync files from source to destination
sync_files() {
    SRC_DIR=$1
    DEST_DIR=$2

    for SRC_FILE in "$SRC_DIR"/*; do
        FILE_NAME=$(basename "$SRC_FILE")
        DEST_FILE="$DEST_DIR/$FILE_NAME"

        # Check if the file exists in the destination
        if [ -e "$DEST_FILE" ]; then
            # Compare the modification times and sync the latest file
            if [ "$SRC_FILE" -nt "$DEST_FILE" ]; then
                cp "$SRC_FILE" "$DEST_FILE"
                log_message "Updated $DEST_FILE with newer version from $SRC_DIR"
            fi
        else
            # If the file does not exist, copy it
            cp "$SRC_FILE" "$DEST_FILE"
            log_message "Copied $SRC_FILE to $DEST_DIR"
        fi
    done
}

# This function removes deleted files from destination
remove_deleted_files() {
    SRC_DIR=$1
    DEST_DIR=$2

    for DEST_FILE in "$DEST_DIR"/*; do
        FILE_NAME=$(basename "$DEST_FILE")
        SRC_FILE="$SRC_DIR/$FILE_NAME"

        # Remove the file if it no longer exists in the source
        if [ ! -e "$SRC_FILE" ]; then
            rm "$DEST_FILE"
            log_message "Removed $DEST_FILE as it no longer exists in $SRC_DIR"
        fi
    done
}

# This ensures the log file exists
touch "$LOG_FILE"

# Syncing in both directions
log_message "Starting synchronization between $DIR1 and $DIR2"
sync_files "$DIR1" "$DIR2"
sync_files "$DIR2" "$DIR1"

# Handle deletions
remove_deleted_files "$DIR1" "$DIR2"
remove_deleted_files "$DIR2" "$DIR1"

log_message "Synchronization complete"
