cat > setup_termux.sh << 'EOF'
#!/bin/bash

echo "🔧 TikTok Bot Setup for Termux"
echo "==============================="

# Update and upgrade
echo "🔄 Updating packages..."
pkg update -y && pkg upgrade -y

# Install basic dependencies
echo "📦 Installing basic dependencies..."
pkg install -y python git nodejs wget curl

# Install Python packages dengan pip
echo "🐍 Installing Python packages..."
pip install --upgrade pip
pip install requests beautifulsoup4 selenium pillow

# Install Chrome and ChromeDriver untuk Termux
echo "🌐 Installing Chrome for Termux..."
pkg install -y x11-repo
pkg install -y tigervnc xorg-xhost
pkg install -y chromium

# Download ChromeDriver
echo "🔧 Setting up ChromeDriver..."
CHROME_DRIVER_VERSION="114.0.5735.90"
wget https://storage.googleapis.com/chrome-for-testing-public/${CHROME_DRIVER_VERSION}/linux64/chromedriver-linux64.zip
unzip chromedriver-linux64.zip
mv chromedriver-linux64/chromedriver $PREFIX/bin/
chmod +x $PREFIX/bin/chromedriver

# Clean up
rm -rf chromedriver-linux64*

# Install TikTokApi alternative
echo "📱 Installing TikTok scraper..."
pip install TikTokLive pytiktok

echo "✅ Setup complete!"
echo "🚀 Now run: python tiktok_bot_simple.py"
EOF

chmod +x setup_termux.sh
