#!/bin/bash

# TikTok Real Bot Runner
# Termux Edition

echo "🚀 Starting TikTok Real Bot..."

# Check if Python is installed
if ! command -v python &> /dev/null; then
    echo "❌ Python not found! Installing..."
    pkg install python -y
fi

# Install required packages
echo "📦 Installing dependencies..."
pip install TikTokApi playwright requests beautifulsoup4 selenium

# Install browser for playwright
echo "🌐 Setting up browser..."
playwright install

# Make script executable
chmod +x tiktok_real_bot.py

# Run the bot
echo "🎵 Starting TikTok Bot..."
python tiktok_real_bot.py
