#!/bin/bash

# Usage: ./upload.sh image.png folder-name "description"
if [ $# -lt 2 ]; then
    echo "Usage: ./upload.sh <image-file> <folder> [description]"
    echo "Example: ./upload.sh logo.png logos-original 'Add new logo'"
    echo ""
    echo "Available folders:"
    echo "  - logos-original"
    echo "  - text-icons"
    echo "  - event-icons"
    echo "  - steps"
    echo "  - bkgs"
    echo "  - dinners"
    echo "  - animations"
    exit 1
fi

FILE=$1
FOLDER=$2
DESC=${3:-"Add new image"}

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "❌ Error: File '$FILE' not found!"
    exit 1
fi

# Check if folder exists
if [ ! -d "$FOLDER" ]; then
    echo "❌ Error: Folder '$FOLDER' not found!"
    exit 1
fi

# Copy file to folder
cp "$FILE" "$FOLDER/"

# Git operations
git add "$FOLDER/$(basename $FILE)"
git commit -m "$DESC"
git push

# Show the CDN URL
echo "✅ Uploaded! CDN URL:"
echo "https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/$FOLDER/$(basename $FILE)"
