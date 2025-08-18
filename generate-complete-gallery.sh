#!/bin/bash

echo "Generating complete gallery with all images..."

# Get all image files from git
git ls-files | grep -E '\.(png|jpg|jpeg|gif|svg)$' > all-images.txt

# Count them
TOTAL=$(wc -l < all-images.txt)
echo "Found $TOTAL images in repository"

# Create new index with all images
cat > index-complete.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>SoWelcome Assets - Complete Gallery (All 152 Images)</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif; 
            padding: 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container { max-width: 1400px; margin: 0 auto; }
        h1 { color: white; margin-bottom: 20px; }
        .stats {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            display: inline-block;
            margin: 20px 0;
            font-size: 1.2em;
        }
        .search { 
            padding: 12px 20px; 
            width: 100%;
            max-width: 400px;
            margin: 20px 0; 
            border-radius: 25px;
            border: none;
        }
        .folder-section {
            background: white;
            margin: 20px 0;
            padding: 20px;
            border-radius: 10px;
        }
        .folder-title {
            color: #667eea;
            margin-bottom: 15px;
            font-size: 1.2em;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }
        .grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); 
            gap: 15px; 
        }
        .asset { 
            border: 1px solid #ddd; 
            border-radius: 5px; 
            padding: 10px;
            cursor: pointer;
            text-align: center;
            background: white;
            transition: all 0.3s;
        }
        .asset:hover { 
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .asset img { 
            width: 100%; 
            height: 100px; 
            object-fit: contain; 
        }
        .asset-name {
            font-size: 0.85em;
            margin-top: 5px;
            word-break: break-all;
            color: #666;
        }
        .copied { 
            position: fixed; 
            bottom: 20px; 
            right: 20px; 
            background: #4CAF50;
            color: white; 
            padding: 15px 25px; 
            border-radius: 25px; 
            display: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        .nav-links {
            background: rgba(255,255,255,0.2);
            padding: 10px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎨 SoWelcome Complete Assets Gallery</h1>
        <div class="stats" id="stats">Loading...</div>
        <div class="nav-links">
            <a href="index.html">Old Gallery (55 images)</a>
            <a href="cdn-directory.html">CDN Directory</a>
        </div>
        <input type="text" class="search" placeholder="Search images..." id="searchBox">
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
                    <img src="${url}" alt="${name}" loading="lazy" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22100%22 height=%22100%22%3E%3Ctext x=%2250%%22 y=%2250%%22 text-anchor=%22middle%22 fill=%22%23999%22%3EError%3C/text%3E%3C/svg%3E'">
                    <div class="asset-name">${name}</div>
                `;
                grid.appendChild(card);
            });
            
            section.appendChild(grid);
            container.appendChild(section);
        });
        
        document.getElementById('stats').textContent = `📊 Total: ${totalImages} images across ${sortedFolders.length} folders`;
        
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
            document.querySelectorAll('.asset').forEach(asset => {
                const name = asset.querySelector('.asset-name').textContent.toLowerCase();
                asset.style.display = name.includes(search) ? 'block' : 'none';
            });
            
            // Hide empty sections
            document.querySelectorAll('.folder-section').forEach(section => {
                const visibleAssets = section.querySelectorAll('.asset[style="display: block;"], .asset:not([style*="none"])');
                section.style.display = visibleAssets.length > 0 ? 'block' : 'none';
            });
        });
    </script>
</body>
</html>
HTML

echo "✅ Created index-complete.html with $TOTAL images"

# Clean up
rm all-images.txt
