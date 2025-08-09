# SoWelcome Assets CDN Quick Reference

Base URL: `https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/`

## 🎨 Logos
- Main Logo: `logos-original/web_logos/sowelcome-logo-org.png`
- Lemur Icon: `logos-original/web_logos/sowelcome-lemur-icon.png`
- Lemur Icon SVG: `logos-original/web_logos/sowelcome-lemur-icon.svg`
- Header: `logos-original/web_logos/sowelcome-header.jpg`
- 120x120 Logo: `logos-original/web_logos/sowelcome-120x120.png`

## 📝 Text Icons
- Birthday: `text-icons/Birthday-text.png`
- Birthday2: `text-icons/Birthday2-text.png`
- Celebrations: `text-icons/Celebrations-text.png`
- Business Event: `text-icons/BusinessEvent-text.png`
- Business Event2: `text-icons/BusinessEvent2-text.png`
- Graduation: `text-icons/Graduation-text.png`
- Banquettes: `text-icons/Banquettes-text.png`
- Banquettes2: `text-icons/Banquettes2-text.png`
- Concerts: `text-icons/Concerts-text.png`
- Dinners Large: `text-icons/DinnersLarge-text.png`
- Dinners Large2: `text-icons/DinnersLarge2-text.png`
- Spontaneous: `text-icons/Spontaneous-text.png`
- Spontaneous2: `text-icons/Spontaneous2-text.png`
- Topical: `text-icons/Topical-text.png`
- Reunion: `text-icons/reunion-text.png`

## 🎯 Event Icons
- Birthday: `event-icons/icon_web/Birthday.png`
- Banquette: `event-icons/icon_web/banquette.png`
- Business: `event-icons/icon_web/business.png`
- Business Event: `event-icons/icon_web/business_event.png`
- Celebrations: `event-icons/icon_web/celebrations.png`
- Concert: `event-icons/icon_web/concert.png`
- Concerts: `event-icons/icon_web/concerts.png`
- Graduation: `event-icons/icon_web/graduation.png`
- Large Group Dinner: `event-icons/icon_web/largegroupdinner.png`
- Reunion: `event-icons/icon_web/reunion.png`
- Spontaneous: `event-icons/icon_web/spontanous.png`

## 🖼️ Backgrounds
### Abstract Backgrounds
- Hero 1: `bkgs/bkgs_abs/sowelcome_hero_1.jpeg`
- Hero 2-11 (PNG): `bkgs/bkgs_abs/sowelcome_hero_2.png` through `sowelcome_hero_11.png`

### People Backgrounds
- People 1-10: `bkgs/bkg_people/sowelcome_hero_ppl_1.png` through `sowelcome_hero_ppl_10.png`

## 👣 Process Steps
- Steps 1-13: `steps/sowelcome_step_1.png` through `steps/sowelcome_step_13.png`

## 🍽️ Dinner Images
- Dinner: `dinners/dinner.jpeg`
- Party: `dinners/party.jpeg`
- Step 1 Smiling: `dinners/step-1-smiling.png`

## 🎬 Animations
- Various MP4 and Lottie animations in `animations/` folder

## How to Use

### In HTML:
```html
<img src="https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/logos-original/web_logos/sowelcome-logo-org.png">
background-image: url('https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/bkgs/bkgs_abs/sowelcome_hero_1.jpeg');
![SoWelcome Logo](https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/logos-original/web_logos/sowelcome-logo-org.png)
## Step 5: Create the Visual Gallery

```bash
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>SoWelcome Assets Gallery</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; 
            padding: 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        h1 { 
            color: white; 
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        .subtitle {
            color: rgba(255,255,255,0.9);
            margin-bottom: 20px;
        }
        .search { 
            padding: 12px 20px; 
            width: 100%;
            max-width: 400px;
            margin: 20px 0; 
            border: none;
            border-radius: 25px;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .category { 
            background: white; 
            margin: 20px 0; 
            padding: 25px; 
            border-radius: 12px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .category h2 { 
            margin-bottom: 20px; 
            color: #333; 
            font-size: 1.4em;
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
            overflow: hidden; 
            background: white; 
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
        }
        .asset:hover { 
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
            border-color: #667eea;
        }
        .asset img { 
            width: 100%; 
            height: 140px; 
            object-fit: contain; 
            padding: 15px;
            background: #fafafa;
        }
        .asset-name { 
            padding: 10px; 
            font-size: 0.85em; 
            color: #555;
            border-top: 1px solid #f0f0f0; 
            word-break: break-all;
            background: white;
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
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            font-weight: 500;
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from { transform: translateX(100px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        .loading {
            color: white;
            text-align: center;
            padding: 40px;
            font-size: 1.2em;
        }
        .stats {
            background: rgba(255,255,255,0.1);
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin: 20px 0;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎨 SoWelcome Assets Gallery</h1>
        <p class="subtitle">Click any image to copy its CDN link to clipboard</p>
        <div class="stats" id="stats">Loading assets...</div>
        <br>
        <input type="text" class="search" placeholder="Search assets..." id="searchBox">
        
        <div class="category">
            <h2>📌 Logos</h2>
            <div class="grid" id="logos"></div>
        </div>
        
        <div class="category">
            <h2>📝 Text Icons</h2>
            <div class="grid" id="text-icons"></div>
        </div>
        
        <div class="category">
            <h2>🎯 Event Icons</h2>
            <div class="grid" id="event-icons"></div>
        </div>
        
        <div class="category">
            <h2>👣 Process Steps</h2>
            <div class="grid" id="steps"></div>
        </div>
        
        <div class="category">
            <h2>🖼️ Backgrounds</h2>
            <div class="grid" id="backgrounds"></div>
        </div>
        
        <div class="category">
            <h2>🍽️ Dinner Images</h2>
            <div class="grid" id="dinners"></div>
        </div>
        
        <div class="copied" id="copied">✓ Link copied to clipboard!</div>
    </div>
    
    <script>
        const baseURL = 'https://cdn.jsdelivr.net/gh/kaalione/sowelcome-assets-cdn@main/';
        
        const assets = {
            'logos': [
                'logos-original/web_logos/sowelcome-logo-org.png',
                'logos-original/web_logos/sowelcome-lemur-icon.png',
                'logos-original/web_logos/sowelcome-lemur-icon.svg',
                'logos-original/web_logos/sowelcome-header.jpg',
                'logos-original/web_logos/sowelcome-120x120.png',
                'logos-original/web_logos/sowelcome-lemur-no-bkg.svg'
            ],
            'text-icons': [
                'text-icons/Birthday-text.png',
                'text-icons/Birthday2-text.png',
                'text-icons/Celebrations-text.png',
                'text-icons/BusinessEvent-text.png',
                'text-icons/BusinessEvent2-text.png',
                'text-icons/Graduation-text.png',
                'text-icons/Banquettes-text.png',
                'text-icons/Banquettes2-text.png',
                'text-icons/Concerts-text.png',
                'text-icons/DinnersLarge-text.png',
                'text-icons/DinnersLarge2-text.png',
                'text-icons/Spontaneous-text.png',
                'text-icons/Spontaneous2-text.png',
                'text-icons/Topical-text.png',
                'text-icons/reunion-text.png'
            ],
            'event-icons': [
                'event-icons/icon_web/Birthday.png',
                'event-icons/icon_web/banquette.png',
                'event-icons/icon_web/business.png',
                'event-icons/icon_web/business_event.png',
                'event-icons/icon_web/celebrations.png',
                'event-icons/icon_web/concert.png',
                'event-icons/icon_web/concerts.png',
                'event-icons/icon_web/graduation.png',
                'event-icons/icon_web/largegroupdinner.png',
                'event-icons/icon_web/reunion.png',
                'event-icons/icon_web/spontanous.png'
            ],
            'steps': [
                'steps/sowelcome_step_1.png',
                'steps/sowelcome_step_2.png',
                'steps/sowelcome_step_3.png',
                'steps/sowelcome_step_4.png',
                'steps/sowelcome_step_5.png',
                'steps/sowelcome_step_6.png',
                'steps/sowelcome_step_7.png',
                'steps/sowelcome_step_8.png',
                'steps/sowelcome_step_9.png',
                'steps/sowelcome_step_10.png',
                'steps/sowelcome_step_11.png',
                'steps/sowelcome_step_12.png',
                'steps/sowelcome_step_13.png'
            ],
            'backgrounds': [
                'bkgs/bkgs_abs/sowelcome_hero_1.jpeg',
                'bkgs/bkgs_abs/sowelcome_hero_2.png',
                'bkgs/bkgs_abs/sowelcome_hero_3.png',
                'bkgs/bkgs_abs/sowelcome_hero_4.png',
                'bkgs/bkgs_abs/sowelcome_hero_5.png',
                'bkgs/bkg_people/sowelcome_hero_ppl_1.png',
                'bkgs/bkg_people/sowelcome_hero_ppl_2.png',
                'bkgs/bkg_people/sowelcome_hero_ppl_3.png'
            ],
            'dinners': [
                'dinners/dinner.jpeg',
                'dinners/party.jpeg',
                'dinners/step-1-smiling.png'
            ]
        };
        
        function createAssetCard(path) {
            const url = baseURL + path;
            const name = path.split('/').pop();
            return `
                <div class="asset" onclick="copyLink('${url}')" title="Click to copy link">
                    <img src="${url}" alt="${name}" loading="lazy" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22100%22 height=%22100%22%3E%3Ctext x=%2250%%22 y=%2250%%22 text-anchor=%22middle%22 dy=%22.3em%22 fill=%22%23999%22%3EError%3C/text%3E%3C/svg%3E'">
                    <div class="asset-name">${name}</div>
                </div>
            `;
        }
        
        function copyLink(url) {
            navigator.clipboard.writeText(url).then(() => {
                const copied = document.getElementById('copied');
                copied.style.display = 'block';
                setTimeout(() => copied.style.display = 'none', 3000);
            }).catch(err => {
                // Fallback for older browsers
                const textArea = document.createElement("textarea");
                textArea.value = url;
                document.body.appendChild(textArea);
                textArea.select();
                document.execCommand('copy');
                document.body.removeChild(textArea);
                
                const copied = document.getElementById('copied');
                copied.style.display = 'block';
                setTimeout(() => copied.style.display = 'none', 3000);
            });
        }
        
        // Populate galleries
        let totalAssets = 0;
        Object.entries(assets).forEach(([category, files]) => {
            const container = document.getElementById(category);
            if (container) {
                container.innerHTML = files.map(createAssetCard).join('');
                totalAssets += files.length;
            }
        });
        
        // Update stats
        document.getElementById('stats').textContent = `📊 ${totalAssets} assets available`;
        
        // Search functionality
        document.getElementById('searchBox').addEventListener('input', (e) => {
            const search = e.target.value.toLowerCase();
            document.querySelectorAll('.asset').forEach(asset => {
                const name = asset.querySelector('.asset-name').textContent.toLowerCase();
                asset.style.display = name.includes(search) ? 'block' : 'none';
            });
            
            // Hide empty categories
            document.querySelectorAll('.category').forEach(category => {
                const visibleAssets = category.querySelectorAll('.asset[style="display: block;"], .asset:not([style])');
                category.style.display = visibleAssets.length > 0 ? 'block' : 'none';
            });
        });
    </script>
</body>
</html>
