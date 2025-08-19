#!/bin/bash

echo "🚀 Updating Gallery with Images AND Videos..."
echo "=============================================="

cd /Users/linuskaasik/Downloads/SoWelcome_Assets

# Get all image AND video files from git
git ls-files | grep -E '\.(png|jpg|jpeg|gif|svg|PNG|JPG|JPEG|GIF|SVG|mp4|MP4|webm|WEBM|mov|MOV)$' > all-media.txt

# Count them
TOTAL=$(wc -l < all-media.txt)
IMAGE_COUNT=$(git ls-files | grep -E '\.(png|jpg|jpeg|gif|svg|PNG|JPG|JPEG|GIF|SVG)$' | wc -l)
VIDEO_COUNT=$(git ls-files | grep -E '\.(mp4|MP4|webm|WEBM|mov|MOV)$' | wc -l)

echo "📊 Total media files: $TOTAL"
echo "🖼️  Images: $IMAGE_COUNT"
echo "🎬 Videos: $VIDEO_COUNT"

# Create updated gallery with video support
cat > index-complete.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>SoWelcome Assets Gallery - Images & Videos</title>
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
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); 
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
            position: relative;
        }
        .asset:hover { 
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
            border-color: #667eea;
        }
        .asset img, .asset video { 
            width: 100%; 
            height: 150px; 
            object-fit: contain; 
            background: #f5f5f5;
            border-radius: 4px;
        }
        .asset-name {
            font-size: 0.85em;
            margin-top: 8px;
            color: #555;
            word-break: break-all;
            font-weight: 500;
        }
        .video-indicator {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(0,0,0,0.7);
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.8em;
        }
        .asset.video {
            background: #f0f0ff;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>🎨 SoWelcome Complete Media Gallery</h1>
        <p class="subtitle">Images & Videos - Click any item to copy its CDN link</p>
        <div class="stats" id="stats">Loading...</div>
        <br>
        <input type="text" class="search" placeholder="Search files by name..." id="searchBox">
        <div id="folders"></div>
    </div>
    
    <div class="copied" id="copied">✓ Link copied!</div>
    
    <script>
        const baseURL = 'https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/';
        const allMedia = [
HTML

# Add each media file as a JavaScript array element
while IFS= read -r file; do
    echo "            '$file'," >> index-complete.html
done < all-media.txt

cat >> index-complete.html << 'HTML'
        ];
        
        // Group media by folder
        const folders = {};
        const folderLinks = {};
        
        allMedia.forEach(path => {
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
        
        // Create HTML for each folder
        const container = document.getElementById('folders');
        let totalMedia = 0;
        let totalVideos = 0;
        let totalImages = 0;
        
        sortedFolders.forEach(folder => {
            const mediaFiles = folders[folder];
            totalMedia += mediaFiles.length;
            
            const section = document.createElement('div');
            section.className = 'folder-section';
            
            // Count videos and images in this folder
            const videos = mediaFiles.filter(f => /\.(mp4|webm|mov)/i.test(f));
            const images = mediaFiles.filter(f => /\.(png|jpg|jpeg|gif|svg)/i.test(f));
            totalVideos += videos.length;
            totalImages += images.length;
            
            // Add emoji for each folder type
            let emoji = '📁';
            if (folder.includes('event')) emoji = '🎯';
            if (folder.includes('text')) emoji = '📝';
            if (folder.includes('logo')) emoji = '📌';
            if (folder.includes('bkg')) emoji = '🖼️';
            if (folder.includes('step')) emoji = '👣';
            if (folder.includes('dinner')) emoji = '🍽️';
            if (folder.includes('animated')) emoji = '🎬';
            if (videos.length > 0) emoji = '🎬';
            
            // Show counts
            let countText = '';
            if (videos.length > 0 && images.length > 0) {
                countText = `${images.length} images, ${videos.length} videos`;
            } else if (videos.length > 0) {
                countText = `${videos.length} videos`;
            } else {
                countText = `${images.length} images`;
            }
            
            const titleDiv = document.createElement('div');
            titleDiv.className = 'folder-title';
            titleDiv.innerHTML = `
                <span>${emoji} ${folder} (${countText})</span>
                <div class="folder-buttons">
                    <button class="folder-btn" onclick="shareFolder('${folder}')">🔗 Share Folder</button>
                    <button class="folder-btn copy-all" onclick="copyAllLinks('${folder}')">📋 Copy All Links</button>
                </div>
            `;
            section.appendChild(titleDiv);
            
            const grid = document.createElement('div');
            grid.className = 'grid';
            
            mediaFiles.forEach(path => {
                const url = baseURL + path;
                const name = path.split('/').pop();
                const isVideo = /\.(mp4|webm|mov)/i.test(path);
                
                const card = document.createElement('div');
                card.className = isVideo ? 'asset video' : 'asset';
                card.onclick = () => copyLink(url);
                
                if (isVideo) {
                    card.innerHTML = `
                        <video src="${url}" muted preload="metadata" onloadedmetadata="this.currentTime=1">
                            Your browser doesn't support video
                        </video>
                        <div class="video-indicator">🎬 VIDEO</div>
                        <div class="asset-name">${name}</div>
                    `;
                } else {
                    card.innerHTML = `
                        <img src="${url}" alt="${name}" loading="lazy">
                        <div class="asset-name">${name}</div>
                    `;
                }
                
                grid.appendChild(card);
            });
            
            section.appendChild(grid);
            container.appendChild(section);
        });
        
        // Update stats
        document.getElementById('stats').textContent = 
            `📊 Total: ${totalMedia} files (🖼️ ${totalImages} images, 🎬 ${totalVideos} videos) in ${sortedFolders.length} folders`;
        
        function copyLink(url) {
            navigator.clipboard.writeText(url);
            const copied = document.getElementById('copied');
            const fileName = url.split('/').pop();
            const isVideo = /\.(mp4|webm|mov)/i.test(fileName);
            copied.innerHTML = `${isVideo ? '🎬' : '🖼️'} Copied: ${fileName}`;
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
            copied.innerHTML = `📋 Copied ${links.length} links from ${folderName}!`;
            copied.style.display = 'block';
            setTimeout(() => copied.style.display = 'none', 4000);
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
                document.getElementById('stats').textContent = `📊 Showing ${visibleCount} files matching "${search}"`;
            } else {
                document.getElementById('stats').textContent = 
                    `📊 Total: ${totalMedia} files (🖼️ ${totalImages} images, 🎬 ${totalVideos} videos) in ${sortedFolders.length} folders`;
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
rm all-media.txt

# Commit and push
git add index-complete.html update-gallery-with-videos.sh
git commit -m "Update gallery to show both images and videos - $TOTAL media files"
git push

echo ""
echo "✅ SUCCESS! Gallery now shows BOTH images and videos!"
echo "================================"
echo "📊 Total media: $TOTAL files"
echo "🖼️  Images: $IMAGE_COUNT"
echo "🎬 Videos: $VIDEO_COUNT"
echo ""
echo "🌐 Gallery URL: https://kaalione.github.io/sowelcome-assets-cdn/index-complete.html"
echo "⏰ Will be live in 2-3 minutes"
echo ""
echo "🎬 Videos will show with:"
echo "  - Preview thumbnail (1 second in)"
echo "  - 'VIDEO' indicator"
echo "  - Light blue background"
echo "  - Click to copy CDN link just like images!"
