#!/bin/bash

echo "🚀 Updating Gallery with ALL features..."
echo "======================================="

cd /Users/linuskaasik/Downloads/SoWelcome_Assets

# Get all image files from git
git ls-files | grep -E '\.(png|jpg|jpeg|gif|svg|PNG|JPG|JPEG|GIF|SVG)$' > all-images.txt

# Count them
TOTAL=$(wc -l < all-images.txt)
echo "📊 Total images in CDN: $TOTAL"

# Create updated gallery with all features
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }
        .folder-buttons {
            display: flex;
            gap: 10px;
        }
        .folder-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 0.9em;
            transition: all 0.3s;
            white-space: nowrap;
        }
        .folder-btn:hover {
            background: #764ba2;
            transform: translateY(-2px);
        }
        .folder-btn.copy-all {
            background: #4CAF50;
        }
        .folder-btn.copy-all:hover {
            background: #45a049;
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
            z-index: 1000;
            max-width: 400px;
        }
        @keyframes slideIn {
            from { transform: translateX(100px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        .filter-notice {
            background: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
            display: none;
        }
        .clear-filter {
            background: white;
            color: #4CAF50;
            border: none;
            padding: 5px 15px;
            border-radius: 15px;
            cursor: pointer;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎨 SoWelcome Complete Assets Gallery</h1>
        <p class="subtitle">Click any image to copy its CDN link</p>
        <div class="stats" id="stats">Loading...</div>
        <br>
        <div class="filter-notice" id="filterNotice">
            <span id="filterText"></span>
            <button class="clear-filter" onclick="clearFilter()">Clear Filter</button>
        </div>
        <input type="text" class="search" placeholder="Search images by name..." id="searchBox">
        <div id="folders"></div>
    </div>
    
    <div class="copied" id="copied">✓ Link copied!</div>
    
    <script>
        const baseURL = 'https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/';
        const allImages = [
HTML

# Add each image file as a JavaScript array element
while IFS= read -r file; do
    echo "            '$file'," >> index-complete.html
done < all-images.txt

cat >> index-complete.html << 'HTML'
        ];
        
        // Group images by folder
        const folders = {};
        const folderLinks = {}; // Store all links per folder
        
        allImages.forEach(path => {
            if (!path) return;
            const parts = path.split('/');
            let folderName = parts[0];
            if (parts.length > 2 && parts[0] === 'event-icons') {
                folderName = parts[0] + '/' + parts[1];
            }
            if (!folders[folderName]) {
                folders[folderName] = [];
                folderLinks[folderName] = [];
            }
            folders[folderName].push(path);
            folderLinks[folderName].push(baseURL + path);
        });
        
        // Sort folders alphabetically
        const sortedFolders = Object.keys(folders).sort();
        
        // Check for folder filter in URL
        const urlParams = new URLSearchParams(window.location.search);
        const folderFilter = urlParams.get('folder');
        
        // Create HTML for each folder
        const container = document.getElementById('folders');
        let totalImages = 0;
        let displayedFolders = folderFilter ? [folderFilter] : sortedFolders;
        
        // Show filter notice if filtered
        if (folderFilter) {
            document.getElementById('filterNotice').style.display = 'block';
            document.getElementById('filterText').textContent = `📁 Showing only: ${folderFilter} folder`;
        }
        
        displayedFolders.forEach(folder => {
            if (!folders[folder]) return; // Skip if folder doesn't exist
            
            const images = folders[folder];
            totalImages += images.length;
            
            const section = document.createElement('div');
            section.className = 'folder-section';
            section.id = 'folder-' + folder.replace(/[^a-zA-Z0-9]/g, '-');
            
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
            if (folder.includes('Selma')) emoji = '🎨';
            if (folder.includes('New icons')) emoji = '✨';
            
            const titleDiv = document.createElement('div');
            titleDiv.className = 'folder-title';
            titleDiv.innerHTML = `
                <span>${emoji} ${folder} (${images.length} images)</span>
                <div class="folder-buttons">
                    <button class="folder-btn" onclick="shareFolder('${folder}')">🔗 Share Folder</button>
                    <button class="folder-btn copy-all" onclick="copyAllLinks('${folder}')">📋 Copy All Links</button>
                </div>
            `;
            section.appendChild(titleDiv);
            
            const grid = document.createElement('div');
            grid.className = 'grid';
            
            images.forEach(path => {
                const url = baseURL + path;
                const name = path.split('/').pop();
                
                const card = document.createElement('div');
                card.className = 'asset';
                card.onclick = () => copyLink(url);
                card.innerHTML = `
                    <img src="${url}" alt="${name}" loading="lazy" onerror="this.style.opacity='0.5'">
                    <div class="asset-name">${name}</div>
                `;
                grid.appendChild(card);
            });
            
            section.appendChild(grid);
            container.appendChild(section);
        });
        
        // Update stats
        if (folderFilter) {
            document.getElementById('stats').textContent = `📊 ${totalImages} images in ${folderFilter} folder`;
        } else {
            document.getElementById('stats').textContent = `📊 ${allImages.length} images in ${sortedFolders.length} folders`;
        }
        
        function copyLink(url) {
            navigator.clipboard.writeText(url);
            const copied = document.getElementById('copied');
            copied.textContent = '✓ Copied: ' + url.split('/').pop();
            copied.style.display = 'block';
            setTimeout(() => copied.style.display = 'none', 3000);
        }
        
        function shareFolder(folderName) {
            const shareUrl = window.location.origin + window.location.pathname + '?folder=' + encodeURIComponent(folderName);
            navigator.clipboard.writeText(shareUrl);
            const copied = document.getElementById('copied');
            copied.innerHTML = '🔗 Folder link copied!<br><small>' + shareUrl + '</small>';
            copied.style.display = 'block';
            setTimeout(() => copied.style.display = 'none', 4000);
        }
        
        function copyAllLinks(folderName) {
            const links = folderLinks[folderName];
            const linksText = links.join('\n');
            navigator.clipboard.writeText(linksText);
            
            const copied = document.getElementById('copied');
            copied.innerHTML = `📋 Copied ${links.length} links from ${folderName}!<br><small>Paste them anywhere</small>`;
            copied.style.display = 'block';
            setTimeout(() => copied.style.display = 'none', 4000);
        }
        
        function clearFilter() {
            window.location.href = window.location.pathname;
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
                document.getElementById('stats').textContent = `📊 Showing ${visibleCount} images matching "${search}"`;
            } else if (folderFilter) {
                document.getElementById('stats').textContent = `📊 ${totalImages} images in ${folderFilter} folder`;
            } else {
                document.getElementById('stats').textContent = `📊 ${allImages.length} images in ${sortedFolders.length} folders`;
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

# Commit and push the updated gallery
git add index-complete.html update-gallery-enhanced.sh
git commit -m "Update gallery with $TOTAL images and Copy All Links feature"
git push

echo ""
echo "✅ SUCCESS! Gallery updated with ALL features!"
echo "================================"
echo "📊 Total images: $TOTAL (including your new ones!)"
echo ""
echo "🆕 NEW FEATURES:"
echo "  1. 🔗 Share Folder - Copies shareable link to just that folder"
echo "  2. 📋 Copy All Links - Copies ALL image URLs from that folder"
echo ""
echo "🌐 Gallery URL: https://kaalione.github.io/sowelcome-assets-cdn/index-complete.html"
echo "⏰ Will be live in 2-3 minutes"
echo ""
echo "💡 Example: Click 'Copy All Links' on the Selma folder to get all 3 URLs at once!"
