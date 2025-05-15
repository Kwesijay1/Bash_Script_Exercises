#!/bin/bash
# This script keeps the core functionality—adding prefixes, suffixes, counters, 
#and dates—without the complexity of regular expressions or detailed error handling.

# This functions to display usage instructions
usage() {
    echo "Usage: $0 [options] [directory]"
    echo "Options:"
    echo "  -p PREFIX   Add a prefix to filenames"
    echo "  -s SUFFIX   Add a suffix to filenames"
    echo "  -c          Add a counter to filenames"
    echo "  -d          Add the current date to filenames"
    echo "  -h          Display this help message"
    exit 1
}

# Parse command-line arguments
prefix=""
suffix=""
counter="false"
date="false"

while getopts "p:s:cdh" opt; do
    case $opt in
        p) prefix=$OPTARG ;;
        s) suffix=$OPTARG ;;
        c) counter="true" ;;
        d) date="true" ;;
        h) usage ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

# Check if directory is provided
if [[ $# -ne 1 ]]; then
    usage
fi

directory=$1

# Ensure the directory exists
if [[ ! -d "$directory" ]]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# Rename files in the directory
count=1
current_date=$(date +%Y%m%d)

for file in "$directory"/*; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        extension="${filename##*.}"
        name="${filename%.*}"

        # Apply prefix
        [[ -n "$prefix" ]] && name="${prefix}${name}"

        # Apply suffix
        [[ -n "$suffix" ]] && name="${name}${suffix}"

        # Apply counter
        [[ "$counter" == "true" ]] && name="${name}_${count}"

        # Apply date
        [[ "$date" == "true" ]] && name="${name}_${current_date}"

        # Rename file
        mv "$file" "$directory/${name}.${extension}"
        echo "Renamed '$file' to '${name}.${extension}'"

        count=$((count + 1))
    fi
done