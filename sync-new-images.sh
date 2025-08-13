#!/bin/bash

# Navigate to repo
cd /Users/linuskaasik/Downloads/SoWelcome_Assets

echo "🔍 Checking for changes..."

# Check if there are any changes (including new folders)
if [ -z "$(git status --porcelain)" ]; then 
    echo "✅ No new images or folders to upload. Repository is up to date."
    exit 0
fi

# Show what's new/changed
echo ""
echo "📊 Found changes:"
git status --short

# Count new folders
NEW_FOLDERS=$(git status --porcelain | grep "^??" | grep "/" | cut -d'/' -f1 | sort -u | wc -l | tr -d ' ')
if [ "$NEW_FOLDERS" -gt 0 ]; then
    echo ""
    echo "📁 New folders detected:"
    git status --porcelain | grep "^??" | grep "/" | cut -d'/' -f1 | sort -u | sed 's/^?? /  - /'
fi

# Count new images (including in new folders)
NEW_COUNT=$(git status --porcelain | grep -E '\.(png|jpg|jpeg|gif|svg|webp|PNG|JPG|JPEG|GIF|SVG|WEBP)$' | wc -l | tr -d ' ')

echo ""
if [ "$NEW_COUNT" -eq 0 ]; then
    echo "📝 Found non-image changes"
    COMMIT_MSG="Update files"
else
    echo "🖼️  Found $NEW_COUNT new image(s)"
    
    # List new images by folder
    echo ""
    echo "New images by location:"
    git status --porcelain | grep -E '\.(png|jpg|jpeg|gif|svg|webp|PNG|JPG|JPEG|GIF|SVG|WEBP)$' | while read line; do
        file=$(echo "$line" | sed 's/^.. //')
        folder=$(dirname "$file")
        filename=$(basename "$file")
        echo "  📍 $folder/ → $filename"
    done
    
    if [ "$NEW_COUNT" -eq 1 ]; then
        NEW_FILE=$(git status --porcelain | grep -E '\.(png|jpg|jpeg|gif|svg|webp|PNG|JPG|JPEG|GIF|SVG|WEBP)$' | head -1 | sed 's/^.. //')
        COMMIT_MSG="Add $(basename "$NEW_FILE")"
    else
        if [ "$NEW_FOLDERS" -gt 0 ]; then
            COMMIT_MSG="Add $NEW_COUNT new images in $NEW_FOLDERS new folder(s)"
        else
            COMMIT_MSG="Add $NEW_COUNT new images"
        fi
    fi
fi

# Add all changes (including new folders)
echo ""
echo "📤 Uploading to GitHub..."
git add .

# Commit with descriptive message
git commit -m "$COMMIT_MSG"

# Push to GitHub
git push

echo ""
echo "✅ Successfully uploaded changes to GitHub!"
echo ""
echo "📎 New image CDN URLs:"
echo "================================"

# Show CDN URLs for all new images (including those in new folders)
git diff --name-only HEAD~1 | grep -E '\.(png|jpg|jpeg|gif|svg|webp|PNG|JPG|JPEG|GIF|SVG|WEBP)$' | while read file; do
    echo "https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/$file"
done

echo "================================"
echo ""
echo "💡 Tip: Visit the gallery to see all images:"
echo "   https://kaalione.github.io/sowelcome-assets-cdn/"
echo ""
echo "📚 Or check the directory for all links:"
echo "   https://kaalione.github.io/sowelcome-assets-cdn/cdn-directory.html"
