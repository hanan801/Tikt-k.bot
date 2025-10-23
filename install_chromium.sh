cat > install_chromium.sh << 'EOF'
#!/bin/bash

echo "🔧 Installing Chromium for Termux..."

# Install Chromium
pkg install x11-repo -y
pkg install chromium -y

echo "✅ Chromium installed!"
echo "⚠️  Note: Real browser automation might not work perfectly in Termux"
echo "🚀 Run: ./run_simple.sh to start the bot"
EOF
