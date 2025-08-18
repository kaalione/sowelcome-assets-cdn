#!/bin/bash

echo "🚀 SoWelcome CDN Auto-Update Starting..."
echo "======================================="

# Navigate to repo
cd /Users/linuskaasik/Downloads/SoWelcome_Assets

# Step 1: Check for new files
echo "📊 Checking for new images..."
NEW_FILES=$(git status --porcelain | grep -E '\.(png|jpg|jpeg|gif|svg|PNG|JPG|JPEG|GIF|SVG)$' | wc -l | tr -d ' ')

if [ "$NEW_FILES" -gt 0 ]; then
    echo "✅ Found $NEW_FILES new image(s)"
    
    # Add and commit new images
    git add "**/*.png" "**/*.jpg" "**/*.jpeg" "**/*.gif" "**/*.svg" "**/*.PNG" "**/*.JPG" "**/*.JPEG" "**/*.GIF" "**/*.SVG"
    git commit -m "Add $NEW_FILES new images"
    git push
    echo "📤 New images uploaded to GitHub"
else
    echo "ℹ️  No new images to upload"
fi

# Step 2: Regenerate the complete gallery
echo ""
echo "🔄 Updating gallery with all images..."

# Get all image files from git
git ls-files | grep -E '\.(png|jpg|jpeg|gif|svg|PNG|JPG|JPEG|GIF|SVG)$' > all-images.txt

# Count them
TOTAL=$(wc -l < all-images.txt)
echo "📊 Total images in CDN: $TOTAL"

# Create updated gallery
cat > index-complete.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>SoWelcome Assets Gallery - Complete Collection</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, Arial, sans-serif; 
            padding: 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container { max-width: 1400px; margin: 0 auto; }
        h1 { color: white; margin-bottom: 10px; text-shadow: 2px 2px 4px rgba(0,0,0,0.2); }
        .subtitle { color: rgba(255,255,255,0.9); margin-bottom: 20px; }
        .stats {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            display: inline-block;
            margin: 20px 0;
            font-size: 1.2em;
            font-weight: bold;
        }
        .last-updated {
            color: rgba(255,255,255,0.8);
            font-size: 0.9em;
            margin-left: 20px;
        }
        .search { 
            padding: 12px 20px; 
            width: 100%;
            max-width: 500px;
            margin: 20px 0; 
            border-radius: 25px;
            border: none;
            font-size: 16px;
        }
        .folder-section {
            background: white;
            margin: 20px 0;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .folder-title {
            color: #667eea;
            margin-bottom: 20px;
            font-size: 1.3em;
            border-bottom: 2px solid #667eea;
            padding-bottom: 10px;
        }
        .grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); 
            gap: 20px; 
        }
        .asset { 
            border: 2px solid #f0f0f0; 
            border-radius: 8px; 
            padding: 12px;
            cursor: pointer;
            text-align: center;
            background: white;
            transition: all 0.3s;
        }
        .asset:hover { 
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
            border-color: #667eea;
        }
        .asset img { 
            width: 100%; 
            height: 120px; 
            object-fit: contain; 
        }
        .asset-name {
            font-size: 0.85em;
            margin-top: 8px;
            color: #555;
            word-break: break-all;
            font-weight: 500;
        }
        .copied { 
            position: fixed; 
            bottom: 30px; 
            right: 30px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
            padding: 15px 25px; 
            border-radius: 25px; 
            display: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from { transform: translateX(100px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎨 SoWelcome Complete Assets Gallery</h1>
        <p class="subtitle">Click any image to copy its CDN link</p>
        <div class="stats" id="stats">Loading...</div>
        <span class="last-updated">Last updated: TIMESTAMP</span>
        <br>
        <input type="text" class="search" placeholder="Search images by name..." id="searchBox">
        <div id="folders"></div>
    </div>
    
    <div class="copied" id="copied">✓ Link copied!</div>
    
    <script>
        const baseURL = 'https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/';
        const allImages = [
HTML

# Replace TIMESTAMP with current date/time
sed -i '' "s/TIMESTAMP/$(date '+%Y-%m-%d %H:%M')/g" index-complete.html

# Add each image file as a JavaScript array element
while IFS= read -r file; do
    echo "            '$file'," >> index-complete.html
done < all-images.txt

cat >> index-complete.html << 'HTML'
        ];
        
        // Group images by folder
        const folders = {};
        allImages.forEach(path => {
            if (!path) return;
            const parts = path.split('/');
            let folderName = parts[0];
            if (parts.length > 2 && parts[0] === 'event-icons') {
                folderName = parts[0] + '/' + parts[1];
            }
            if (!folders[folderName]) folders[folderName] = [];
            folders[folderName].push(path);
        });
        
        // Sort folders alphabetically
        const sortedFolders = Object.keys(folders).sort();
        
        // Create HTML for each folder
        const container = document.getElementById('folders');
        let totalImages = 0;
        
        sortedFolders.forEach(folder => {
            const images = folders[folder];
            totalImages += images.length;
            
            const section = document.createElement('div');
            section.className = 'folder-section';
            
            // Add emoji for each folder type
            let emoji = '📁';
            if (folder.includes('event')) emoji = '🎯';
            if (folder.includes('text')) emoji = '📝';
            if (folder.includes('logo')) emoji = '📌';
            if (folder.includes('bkg')) emoji = '🖼️';
            if (folder.includes('step')) emoji = '👣';
            if (folder.includes('dinner')) emoji = '🍽️';
            if (folder.includes('animated')) emoji = '🎬';
            if (folder.includes('cluster')) emoji = '🎨';
            if (folder.includes('niki')) emoji = '🖼️';
            if (folder.includes('venue')) emoji = '📄';
            
            const title = document.createElement('h2');
            title.className = 'folder-title';
            title.textContent = `${emoji} ${folder} (${images.length} images)`;
            section.appendChild(title);
            
            const grid = document.createElement('div');
            grid.className = 'grid';
            
            images.forEach(path => {
                const url = baseURL + path;
                const name = path.split('/').pop();
                
                const card = document.createElement('div');
                card.className = 'asset';
                card.onclick = () => copyLink(url);
                card.innerHTML = `
                    <img src="${url}" alt="${name}" loading="lazy">
                    <div class="asset-name">${name}</div>
                `;
                grid.appendChild(card);
            });
            
            section.appendChild(grid);
            container.appendChild(section);
        });
        
        document.getElementById('stats').textContent = `📊 ${totalImages} images in ${sortedFolders.length} folders`;
        
        function copyLink(url) {
            navigator.clipboard.writeText(url);
            const copied = document.getElementById('copied');
            copied.textContent = '✓ Copied: ' + url.split('/').pop();
            copied.style.display = 'block';
            setTimeout(() => copied.style.display = 'none', 3000);
        }
        
        // Search functionality
        document.getElementById('searchBox').addEventListener('input', (e) => {
            const search = e.target.value.toLowerCase();
            let visibleCount = 0;
            
            document.querySelectorAll('.asset').forEach(asset => {
                const name = asset.querySelector('.asset-name').textContent.toLowerCase();
                const isVisible = name.includes(search);
                asset.style.display = isVisible ? 'block' : 'none';
                if (isVisible) visibleCount++;
            });
            
            // Update count
            if (search) {
                document.getElementById('stats').textContent = `📊 Showing ${visibleCount} of ${totalImages} images`;
            } else {
                document.getElementById('stats').textContent = `📊 ${totalImages} images in ${sortedFolders.length} folders`;
            }
            
            // Hide empty sections
            document.querySelectorAll('.folder-section').forEach(section => {
                const visibleAssets = section.querySelectorAll('.asset:not([style*="none"])');
                section.style.display = visibleAssets.length > 0 ? 'block' : 'none';
            });
        });
    </script>
</body>
</html>
HTML

# Clean up
rm all-images.txt

# Step 3: Commit and push the updated gallery
git add index-complete.html
git commit -m "Auto-update gallery with $TOTAL images"
git push

echo ""
echo "✅ SUCCESS! CDN fully updated!"
echo "================================"
echo "📊 Total images: $TOTAL"
echo "🌐 Gallery URL: https://kaalione.github.io/sowelcome-assets-cdn/index-complete.html"
echo "⏰ Gallery will be live in 2-3 minutes"
echo ""
echo "💡 TIP: Run './auto-update-cdn.sh' anytime to update everything!"
