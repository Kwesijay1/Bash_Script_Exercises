# File Encryption and Decryption Tool

This project is a Bash script designed to securely encrypt and decrypt files using the OpenSSL library. It provides a simple and user-friendly command-line interface for handling sensitive files with robust encryption methods.

## Features

- **File Encryption**: Encrypt a file using AES-256-CBC encryption. The original file is securely deleted after successful encryption, ensuring data confidentiality.
- **File Decryption**: Decrypt an encrypted `.enc` file to restore the original file using the same password that was used during encryption.
- **Password Protection**: Securely handle passwords by allowing user input without displaying it on the terminal.

## Usage

The script supports two main operations:
1. **Encryption**: Use the `-e` flag followed by the file name to encrypt a file.
2. **Decryption**: Use the `-d` flag followed by the file name to decrypt a file.

### Command Examples

#### Encrypt a File
```bash
./file_crypto_tool.sh -e <file_to_encrypt>
```
- The script will prompt you to enter a password for encryption.
- After encryption, the original file will be deleted, and a new encrypted file with the `.enc` extension will be created.

#### Decrypt a File
```bash
./file_crypto_tool.sh -d <file_to_decrypt>
```
- The script will prompt you to enter the password used during encryption.
- If successful, the original file will be restored from the encrypted file.

### Example Workflow
1. Encrypt a file called `example.txt`:
   ```bash
   ./file_crypto_tool.sh -e example.txt
   ```
   - This creates `example.txt.enc` and deletes `example.txt`.

2. Decrypt the file back to its original form:
   ```bash
   ./file_crypto_tool.sh -d example.txt.enc
   ```
   - This recreates `example.txt`.

## Prerequisites

- **Bash Shell**: Ensure you have a Bash shell environment to run the script.
- **OpenSSL**: The script uses OpenSSL for encryption and decryption. You can install it using:
  ```bash
  sudo apt install openssl   # For Debian/Ubuntu
  brew install openssl       # For macOS
  ```
- **File Permissions**: The script must have executable permissions:
  ```bash
  chmod +x file_crypto_tool.sh
  ```

## How It Works

1. **Encryption**:
   - The script encrypts the specified file using AES-256-CBC encryption.
   - The encrypted file is saved with a `.enc` extension.
   - The original file is securely deleted after successful encryption.

2. **Decryption**:
   - The script decrypts the `.enc` file using the password provided during encryption.
   - The original file is restored with its original name.

## Security Notes

- **Password Security**: Always use a strong password for encryption. The password is not stored by the script.
- **File Deletion**: The original file is deleted after encryption. Ensure you have backups if required.
- **Integrity**: If the password is incorrect or the `.enc` file is corrupted, decryption will fail.

## Disclaimer

This tool is provided as-is and should not be used for critical or highly sensitive data without proper testing and understanding of its workings. The user assumes all responsibility for data security and recovery.

---

Enjoy secure file management with this tool!