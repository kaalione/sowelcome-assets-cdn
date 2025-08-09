#!/bin/bash

# Navigate to repo
cd /Users/linuskaasik/Downloads/SoWelcome_Assets

# Check if there are any changes
if [ -z "$(git status --porcelain)" ]; then 
    echo "✅ No new images to upload. Repository is up to date."
    exit 0
fi

# Show what's new/changed
echo "🔍 Found changes:"
git status --short

# Count new images
NEW_COUNT=$(git status --porcelain | grep -E '\.(png|jpg|jpeg|gif|svg|webp|PNG|JPG|JPEG)$' | wc -l | tr -d ' ')

if [ "$NEW_COUNT" -eq 0 ]; then
    echo "📝 Found non-image changes"
    git add .
    git commit -m "Update files"
else
    # Add all changes
    git add .
    
    # Create descriptive commit message
    if [ "$NEW_COUNT" -eq 1 ]; then
        NEW_FILE=$(git status --porcelain | grep -E '\.(png|jpg|jpeg|gif|svg|webp|PNG|JPG|JPEG)$' | head -1 | sed 's/^.. //')
        COMMIT_MSG="Add $(basename "$NEW_FILE")"
    else
        COMMIT_MSG="Add $NEW_COUNT new images"
    fi
    
    git commit -m "$COMMIT_MSG"
fi

# Push to GitHub
git push

echo "✅ Successfully uploaded changes to GitHub!"
echo ""
echo "📎 New image CDN URLs:"
git diff --name-only HEAD~1 | grep -E '\.(png|jpg|jpeg|gif|svg|webp|PNG|JPG|JPEG)$' | while read file; do
    echo "https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/$file"
done
