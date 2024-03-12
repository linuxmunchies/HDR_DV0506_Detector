
# HDR Dolby Vision Profile 05 Level 06 Detector

## Overview

This Bash script is designed for the automated detection and optional deletion of MKV files encoded with the 'dvhe.05.06' HDR format within a specified directory. It is particularly useful for managing digital media libraries, ensuring compatibility, and enforcing encoding standards. Although primarily tested on .mkv files, it may work on other file types if `mediainfo` can identify the correct field.

## Features

- **Automated Detection**: Efficiently scans a specified directory and its subdirectories for MKV files, identifying those with the 'dvhe.05.06' HDR format.
- **Selective Deletion**: Offers the option to automatically delete identified files, with an interactive mode for confirmation and a non-interactive mode for automated workflows.
- **User-Friendly Interface**: Includes command-line options for help, directory specification, and file deletion control.
- **Prerequisite Check**: Automatically verifies the presence of necessary utilities (`mediainfo`) before execution.

## Prerequisites

- Bash shell environment
- `mediainfo` utility installed on the system

## Installation

1. Clone the repository or download the script directly.
2. Make the script executable with `chmod +x dv0506detect.sh`.

## Usage

```bash
./dv0506detect.sh [-h] [-d DIRECTORY] [-r]
```

- `-h`: Display help information and exit.
- `-d DIRECTORY`: Specify the directory to scan for MKV files. Defaults to `/mnt/media/movies/`.
- `-r`: Remove files identified with the 'dvhe.05.06' HDR format without asking for confirmation. Use with caution.

### Examples

- To scan the default directory and list files:

```bash
./dv0506detect.sh
```

- To scan a specific directory:

```bash
./dv0506detect.sh -d /path/to/your/movies
```

- To scan and remove files without confirmation:

```bash
./dv0506detect.sh -r
```

## Contributing

Contributions are welcome. Please feel free to fork the repository, make improvements, and submit pull requests. I am still new, so please bear (heh) with me!

## License

This project is licensed under the MIT License!
