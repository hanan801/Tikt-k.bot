cat > run_simple.sh << 'EOF'
#!/bin/bash

echo "🚀 Starting TikTok Simple Bot..."

# Check if Python is installed
if ! command -v python &> /dev/null; then
    echo "❌ Python not found! Please run: pkg install python"
    exit 1
fi

# Check if required packages are installed
echo "🔍 Checking dependencies..."
python -c "import requests, selenium, beautifulsoup4" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "📦 Installing missing dependencies..."
    pip install requests beautifulsoup4 selenium
fi

# Check if ChromeDriver is available
if ! command -v chromedriver &> /dev/null; then
    echo "⚠️  ChromeDriver not found. Real copy link may not work."
    echo "💡 You can install it with: pkg install chromium"
fi

echo "🎵 Starting TikTok Bot..."
python tiktok_bot_simple.py
EOF

chmod +x run_simple.sh
