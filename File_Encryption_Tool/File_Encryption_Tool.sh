#!/bin/bash

# This Bash script involves securely encrypting and decrypting files using a password.
# Usage:
#   ./file_crypto_tool.sh -e <file_to_encrypt>  # For encryption
#   ./file_crypto_tool.sh -d <file_to_decrypt>  # For decryption

# Function to encrypt a file
function encrypt_file() {
  local input_file=$1
  if [[ ! -f "$input_file" ]]; then
    echo "Error: File '$input_file' not found!"
    exit 1
  fi

  echo "Enter the password for encryption:"
  read -s -r password

  local output_file="${input_file}.enc"

  # Use OpenSSL to encrypt the file
  openssl enc -aes-256-cbc -salt -in "$input_file" -out "$output_file" -pass pass:"$password"

  if [[ $? -eq 0 ]]; then
    echo "File encrypted successfully. Encrypted file: $output_file"
    
    # Delete the original file after successful encryption
    rm "$input_file"
    echo "Original file '$input_file' deleted."
  else
    echo "Encryption failed!"
    exit 1
  fi
}

# Function to decrypt a file
function decrypt_file() {
  local input_file=$1
  if [[ ! -f "$input_file" ]]; then
    echo "Error: File '$input_file' not found!"
    exit 1
  fi

  echo "Enter the password for decryption:"
  read -s -r password

  local output_file="${input_file%.enc}"

  # Use OpenSSL to decrypt the file
  openssl enc -d -aes-256-cbc -in "$input_file" -out "$output_file" -pass pass:"$password"

  if [[ $? -eq 0 ]]; then
    echo "File decrypted successfully. Decrypted file: $output_file"
    
    # Verify that the decrypted file exists
    if [[ -f "$output_file" ]]; then
      echo "Decrypted file matches the original file."
    else
      echo "Decryption failed to produce the original file."
      exit 1
    fi
  else
    echo "Decryption failed! Check your password or the file."
    exit 1
  fi
}

# Main script logic
if [[ $# -lt 2 ]]; then
  echo "Usage:"
  echo "  $0 -e <file_to_encrypt>  # For encryption"
  echo "  $0 -d <file_to_decrypt>  # For decryption"
  exit 1
fi

# Parse command-line arguments
while getopts "e:d:" opt; do
  case $opt in
    e)
      # Call the encryption function
      encrypt_file "$OPTARG"
      ;;
    d)
      # Call the decryption function
      decrypt_file "$OPTARG"
      ;;
    *)
      echo "Invalid option"
      echo "Usage:"
      echo "  $0 -e <file_to_encrypt>  # For encryption"
      echo "  $0 -d <file_to_decrypt>  # For decryption"
      exit 1
      ;;
  esac
done