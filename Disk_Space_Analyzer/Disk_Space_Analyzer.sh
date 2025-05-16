#!/bin/bash

# Disk Space Analyzer Script with Tree-like Output
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

# Function to format and display disk usage with tree structure
analyze_disk_usage() {
  local dir="$1"
  local indent="$2"
  local filter="$3"
  local prefix="$4"
  local is_last="$5"
  
  # Get list of items in directory
  local items=()
  while IFS= read -r line; do
    items+=("$line")
  done < <(du -sh "$dir"/* 2>/dev/null)
  
  # Sort items based on the specified criteria
  if [[ "$SORT" == "size" ]]; then
    IFS=$'\n' sorted_items=($(printf "%s\n" "${items[@]}" | sort -hr))
  else
    IFS=$'\n' sorted_items=($(printf "%s\n" "${items[@]}" | sort -k2))
  fi
  
  local count=${#sorted_items[@]}
  local i=0
  
  for line in "${sorted_items[@]}"; do
    i=$((i+1))
    size=$(echo "$line" | awk '{print $1}')
    path=$(echo "$line" | awk '{print $2}')
    name=$(basename "$path")
    
    # Apply filter if specified
    if [[ -n "$filter" ]]; then
      operator=$(echo "$filter" | grep -oE '[<>]')
      threshold=$(echo "$filter" | grep -oE '[0-9]+[KMG]')
      size_in_bytes=$(numfmt --from=iec "$size")
      threshold_in_bytes=$(numfmt --from=iec "$threshold")
      
      if [[ "$operator" == ">" && "$size_in_bytes" -le "$threshold_in_bytes" ]]; then
        continue
      elif [[ "$operator" == "<" && "$size_in_bytes" -ge "$threshold_in_bytes" ]]; then
        continue
      fi
    fi
    
    # Determine tree characters
    local tree_char=""
    if [[ "$is_last" == "true" ]]; then
      tree_char="└── "
      new_prefix="$prefix    "
    else
      tree_char="├── "
      new_prefix="$prefix│   "
    fi
    
    # Display the item with tree structure
    echo "${prefix}${tree_char}${size} ${name}"
    
    # Recursively analyze subdirectories
    if [[ -d "$path" ]]; then
      if [[ $i -eq $count ]]; then
        analyze_disk_usage "$path" "$indent" "$filter" "$new_prefix" "true"
      else
        analyze_disk_usage "$path" "$indent" "$filter" "$new_prefix" "false"
      fi
    fi
  done
}

# Main execution
echo "Analyzing disk usage in: $DIR"
echo "$DIR"
analyze_disk_usage "$DIR" "" "$FILTER" "" "true"