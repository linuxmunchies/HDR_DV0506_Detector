#!/bin/bash

# Function to check if mediainfo is installed
check_mediainfo_installed() {
    if ! command -v mediainfo &> /dev/null; then
        echo "mediainfo could not be found. Please install mediainfo and try again."
        exit 1
    fi
}

# Function to confirm file deletion
confirm_deletion() {
    read -p "Do you really want to delete this file? [y/N] " confirm
    case "$confirm" in 
        [yY][eE][sS]|[yY]) true ;;
        *) false ;;
    esac
}

# Function to display help
show_help() {
cat << EOF
Usage: ${0##*/} [-h] [-d DIRECTORY] [-r]

Search for MKV files in the specified directory and subdirectories that are encoded with the 'dvhe.05.06' HDR format.

    -h          display this help and exit
    -d          set the directory to search for MKV files (default is /mnt/media/movies/)
    -r          remove files that match the criteria without confirmation (use with caution)
EOF
}

# Default values
search_dir="/mnt/media/movies/"
remove_files=false

# Parse command-line options
while getopts "hrd:" opt; do
    case "${opt}" in
        h)
            show_help
            exit 0
            ;;
        d)
            search_dir=$OPTARG
            ;;
        r)
            remove_files=true
            ;;
        *)
            show_help >&2
            exit 1
            ;;
    esac
done

# Enhanced CLI output
echo "HDR DV0506 Detector By KernelAGI!"
echo "Scanning directory: $search_dir for MKV files..."
echo "=================="

# Check for mediainfo installation
check_mediainfo_installed

# Counter for detected files
count=0

# Loop through all MKV files in the directory
find "$search_dir" -type f -name "*.mkv" | while read -r file; do
    # Get the complete MediaInfo for the file
    full_mediainfo=$(mediainfo "$file")

    # Check if the HDR Format contains 'dvhe.05.06'
    if [[ $full_mediainfo == *"dvhe.05.06"* ]]; then
        echo "dvhe.05.06 detected in $file"
        ((count++))

        if [ "$remove_files" = true ]; then
            rm "$file"
            echo "$file has been deleted."
        elif confirm_deletion; then
            rm "$file"
            echo "$file has been deleted."
        else
            echo "Skipping deletion for $file"
        fi
    fi
done

if [ $count -eq 0 ]; then
    echo "No files with 'dvhe.05.06' HDR format were found."
else
    echo "$count file(s) with 'dvhe.05.06' HDR format detected."
fi
