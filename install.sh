#!/bin/bash

echo "🎵 TikTok Real Bot Installation"
echo "================================"

# Update packages
echo "🔄 Updating packages..."
pkg update -y && pkg upgrade -y

# Install dependencies
echo "📦 Installing dependencies..."
pkg install -y python git nodejs ffmpeg

# Install Python packages
echo "🐍 Installing Python packages..."
pip install TikTokApi playwright requests beautifulsoup4 selenium pillow

# Install Playwright browser
echo "🌐 Installing browser..."
playwright install

# Download ChromeDriver for Termux
echo "🔧 Setting up ChromeDriver..."
pkg install -y wget
wget https://chromedriver.storage.googleapis.com/$(curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
chmod +x chromedriver
mv chromedriver $PREFIX/bin/

# Make scripts executable
chmod +x run_bot.sh
chmod +x install.sh

echo "✅ Installation complete!"
echo "🚀 Run: ./run_bot.sh to start the bot"
