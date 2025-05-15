#!/bin/bash

# Disk Space Analyzer Script
# Description: Analyzes disk usage and provides a tree-like display with sorting and filtering options.

# Function to display usage
usage() {
  echo "Usage: $0 [directory] [--sort=size|name] [--filter=size>100M]"
  echo "Options:"
  echo "  directory       The root directory to analyze (default: current directory)"
  echo "  --sort          Sort results by 'size' or 'name' (default: size)"
  echo "  --filter        Filter results by size, e.g., size>100M, size<1G"
  exit 1
}

# Parse arguments
DIR="."
SORT="size"
FILTER=""

for arg in "$@"; do
  case $arg in
    --sort=*)
      SORT="${arg#*=}"
      ;;
    --filter=*)
      FILTER="${arg#*=}"
      ;;
    *)
      DIR="$arg"
      ;;
  esac
done

# Validate sort option
if [[ "$SORT" != "size" && "$SORT" != "name" ]]; then
  echo "Invalid sort option: $SORT"
  usage
fi

# Function to format and display disk usage
analyze_disk_usage() {
  local dir="$1"
  local indent="$2"
  local filter="$3"

  # Get disk usage for the current directory
  du -sh "$dir"/* 2>/dev/null | while read -r line; do
    size=$(echo "$line" | awk '{print $1}')
    path=$(echo "$line" | awk '{print $2}')
    
    # Apply filter if specified
    if [[ -n "$filter" ]]; then
      operator=$(echo "$filter" | grep -oE '[<>]')
      threshold=$(echo "$filter" | grep -oE '[0-9]+[KMG]')
      size_in_bytes=$(numfmt --from=iec "$size")
      threshold_in_bytes=$(numfmt --from=iec "$threshold")
      if ! [[ "$size_in_bytes" "$operator" "$threshold_in_bytes" ]]; then
        continue
      fi
    fi

    # Display the item
    echo "${indent}${size} $(basename "$path")"

    # Recursively analyze subdirectories
    if [[ -d "$path" ]]; then
      analyze_disk_usage "$path" "  $indent" "$filter"
    fi
  done
}

# Main execution
echo "Analyzing disk usage in: $DIR"
if [[ "$SORT" == "size" ]]; then
  analyze_disk_usage "$DIR" "" "$FILTER" | sort -hr
else
  analyze_disk_usage "$DIR" "" "$FILTER" | sort
fi
