#!/bin/bash

echo "🚀 SoWelcome CDN - Syncing ALL Files..."
echo "======================================="

cd /Users/linuskaasik/Downloads/SoWelcome_Assets

# Check for ANY new files
echo "📊 Checking for new files..."
NEW_FILES=$(git status --porcelain | wc -l | tr -d ' ')

if [ "$NEW_FILES" -gt 0 ]; then
    echo "✅ Found $NEW_FILES new file(s)"
    
    # Show what's new by type
    echo ""
    echo "📁 New files by type:"
    
    # Count different file types
    IMG_COUNT=$(git status --porcelain | grep -E '\.(png|jpg|jpeg|gif|svg|PNG|JPG|JPEG|GIF|SVG)$' | wc -l | tr -d ' ')
    PDF_COUNT=$(git status --porcelain | grep -E '\.pdf$' -i | wc -l | tr -d ' ')
    CSV_COUNT=$(git status --porcelain | grep -E '\.(csv|xlsx?)$' -i | wc -l | tr -d ' ')
    OTHER_COUNT=$((NEW_FILES - IMG_COUNT - PDF_COUNT - CSV_COUNT))
    
    [ "$IMG_COUNT" -gt 0 ] && echo "  🖼️  Images: $IMG_COUNT"
    [ "$PDF_COUNT" -gt 0 ] && echo "  📄 PDFs: $PDF_COUNT"
    [ "$CSV_COUNT" -gt 0 ] && echo "  📊 CSV/Excel: $CSV_COUNT"
    [ "$OTHER_COUNT" -gt 0 ] && echo "  📦 Other: $OTHER_COUNT"
    
    # Add all files
    git add -A
    git commit -m "Add $NEW_FILES new files (Images: $IMG_COUNT, PDFs: $PDF_COUNT, Data: $CSV_COUNT)"
    git push
    
    echo ""
    echo "📤 Files uploaded! CDN URLs:"
    echo "================================"
    
    # Show CDN URLs for new files
    git diff --name-only HEAD~1 | while read file; do
        echo "https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/$file"
    done
    
    echo "================================"
else
    echo "ℹ️  No new files to upload"
fi

echo ""
echo "📊 Repository Statistics:"
git ls-files | wc -l | xargs echo "Total files:"
git ls-files | grep -E '\.(png|jpg|jpeg|gif|svg)$' -i | wc -l | xargs echo "Images:"
git ls-files | grep -E '\.pdf$' -i | wc -l | xargs echo "PDFs:"
git ls-files | grep -E '\.(csv|xlsx?)$' -i | wc -l | xargs echo "Data files:"
