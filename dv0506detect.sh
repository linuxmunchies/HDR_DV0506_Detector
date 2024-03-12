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

# Enhanced CLI output
echo "HDR DV0506 Detector By KernelAGI!"
echo "=================="

# Check for mediainfo installation
check_mediainfo_installed

# Allow dynamic input for search directory
echo "Please enter the directory to search for MKV files:"
read -r search_dir
echo "Scanning directory: $search_dir for MKV files..."

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

        # Optionally, ask for confirmation before deleting the file
        if confirm_deletion; then
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
