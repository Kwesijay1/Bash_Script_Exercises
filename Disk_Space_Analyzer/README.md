
```
# Disk Space Analyzer

A bash script that analyzes disk usage and displays it in a tree-like structure with sorting and filtering capabilities.

## Features

- Displays disk usage in a visual tree format
- Supports sorting by size or name
- Allows filtering by file/directory size
- Handles large directories efficiently
- Colorful output for better readability (optional)

## Installation

1. Clone this repository or download the script:
   ```bash
   wget https://raw.githubusercontent.com/yourusername/disk-analyzer/main/disk_analyzer.sh
   ```

2. Make the script executable:
   ```bash
   chmod +x disk_analyzer.sh
   ```

3. (Optional) Move to your bin directory for global access:
   ```bash
   sudo mv disk_analyzer.sh /usr/local/bin/disk-analyzer
   ```

## Usage

```bash
./disk_analyzer.sh [directory] [--sort=size|name] [--filter=size>100M]
```

### Options

| Option        | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| `directory`   | The root directory to analyze (default: current directory)                  |
| `--sort`      | Sort results by 'size' (default) or 'name'                                  |
| `--filter`    | Filter results by size (e.g., `size>100M`, `size<1G`)                       |

### Examples

1. Analyze current directory sorted by size:
   ```bash
   ./disk_analyzer.sh
   ```

2. Analyze `/var` directory sorted by name:
   ```bash
   ./disk_analyzer.sh /var --sort=name
   ```

3. Show only items larger than 500MB in `/home`:
   ```bash
   ./disk_analyzer.sh /home --filter="size>500M"
   ```

4. Show items smaller than 1GB in current directory:
   ```bash
   ./disk_analyzer.sh --filter="size<1G"
   ```

## Sample Output

```
Analyzing disk usage in: /test
/test
└── 120M dir1
    ├── 80M subdir1
    │   ├── 50M file1
    │   └── 30M file2
    └── 40M subdir2
        └── 40M file3
```

## Size Units

The script understands these size units:
- K (Kilobytes)
- M (Megabytes)
- G (Gigabytes)

## Dependencies

- `bash` (v4.0 or later)
- `coreutils` (for du, sort, etc.)
- `grep` (for filtering)
- `awk` (for text processing)

## License

MIT License - Free to use and modify

## Contributing

Contributions are welcome! Please open an issue or pull request for any improvements.

## Troubleshooting

If you encounter issues:
1. Ensure all dependencies are installed
2. Check if you have read permissions for the target directory
3. Verify your filter syntax is correct (e.g., "size>100M" not "size > 100M")
```