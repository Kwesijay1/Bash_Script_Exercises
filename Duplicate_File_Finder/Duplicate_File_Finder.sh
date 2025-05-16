#!/bin/bash

# Function to calculate the hash of a file
calculate_hash() {
  local file=$1
  sha256sum "$file" | awk '{print $1}'
}

# Function to list duplicate files
find_duplicates() {
  declare -A size_map
  declare -A hash_map
  local folder=$1

  # Loop through all files in the folder
  while IFS= read -r -d '' file; do
    # Get the file size
    filesize=$(stat -c%s "$file")
    
    # Group files by size
    if [[ -z ${size_map[$filesize]} ]]; then
      size_map["$filesize"]="$file"
    else
      # Calculate the hash only for files with the same size
      filehash=$(calculate_hash "$file")
      
      if [[ -z ${hash_map[$filehash]} ]]; then
        hash_map["$filehash"]="$file"
      else
        duplicates+=("$file")
        duplicates+=("${hash_map[$filehash]}")
      fi
    fi
  done < <(find "$folder" -type f -print0)

  # Remove duplicate entries in the duplicates array
  duplicates=($(printf "%s\n" "${duplicates[@]}" | sort -u))
}

# Function to display duplicates and offer actions
handle_duplicates() {
  if [[ ${#duplicates[@]} -eq 0 ]]; then
    echo "No duplicate files found."
    exit 0
  fi

  echo "Duplicate files found:"
  for file in "${duplicates[@]}"; do
    echo "$file"
  done

  echo
  echo "What would you like to do with the duplicate files?"
  echo "1. Delete all duplicates"
  echo "2. Move all duplicates to a specific folder"
  echo "3. Do nothing"

  read -rp "Enter your choice (1/2/3): " choice

  case $choice in
    1)
      for file in "${duplicates[@]}"; do
        echo "Deleting: $file"
        rm -f "$file"
      done
      ;;
    2)
      read -rp "Enter the folder path to move duplicates: " move_folder
      mkdir -p "$move_folder"
      for file in "${duplicates[@]}"; do
        echo "Moving: $file to $move_folder"
        mv "$file" "$move_folder"
      done
      ;;
    3)
      echo "No action taken."
      ;;
    *)
      echo "Invalid choice. Exiting."
      ;;
  esac
}

# Main script
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <folder>"
  exit 1
fi

folder=$1
declare -a duplicates
find_duplicates "$folder"
handle_duplicates