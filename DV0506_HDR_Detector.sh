#!/bin/bash

# Usage function to display help
usage() {
    echo "Usage: $0 [-t filetype] file"
    echo "  -t filetype: Specify the file type (e.g., mp4, mkv, etc.)"
    exit 1
}

# Parse command-line arguments
while getopts ":t:" opt; {
  case ${opt} in
    t )
      filetype=$OPTARG
      ;;
    \? )
      usage
      ;;
  esac
}

shift $((OPTIND -1))

# Check if the file is provided
if [ $# -ne 1 ]; then
    usage
fi

file=$1

# Check if mediainfo is installed
if ! command -v mediainfo &> /dev/null
then
    echo "mediainfo could not be found. Please install it to use this script."
    exit
fi

# Check file type if specified
if [ -n "$filetype" ]; then
    extension="${file##*.}"
    if [ "$extension" != "$filetype" ]; then
        echo "File type does not match the specified type: $filetype"
        exit 1
    fi
fi

# Analyze the file with mediainfo
mediainfo "$file"
