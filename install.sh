#!/bin/bash

# Installation Script for TikTok Bot

echo -e "\033[1;34m"
echo "╔════════════════════════════════╗"
echo "║   TIKTOK BOT INSTALLATION     ║"
echo "╚════════════════════════════════╝"
echo -e "\033[0m"

# Update package list
echo -e "\033[1;33m[*] Updating packages...\033[0m"
pkg update -y && pkg upgrade -y

# Install dependencies
echo -e "\033[1;33m[*] Installing dependencies...\033[0m"
pkg install -y python git curl wget jq

# Install Python packages
echo -e "\033[1;33m[*] Installing Python packages...\033[0m"
pip install requests bs4 selenium

# Make scripts executable
echo -e "\033[1;33m[*] Setting up scripts...\033[0m"
chmod +x tiktokbot.sh
chmod +x install.sh
chmod +x modules/*.sh

# Create necessary files
touch session.txt
touch history.log

echo -e "\033[1;32m[✓] Installation completed!\033[0m"
echo -e "\033[1;36m[*] Run: ./tiktokbot.sh to start\033[0m"
