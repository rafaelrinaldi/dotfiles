#!/bin/bash

set -euo pipefail

echo "🛠️  Installing Xcode Command Line Tools..."

if xcode-select -p &>/dev/null; then
    echo "✅ Xcode Command Line Tools already installed at $(xcode-select -p)"
else
    echo "📥 Installing Xcode Command Line Tools..."
    
    xcode-select --install
    
    echo "⏳ Please complete the Xcode Command Line Tools installation in the dialog that appeared."
    echo "   This script will wait for the installation to complete..."
    
    # Wait for installation to complete
    until xcode-select -p &>/dev/null; do
        sleep 5
        echo "   Still waiting for Xcode Command Line Tools installation..."
    done
    
    echo "✅ Xcode Command Line Tools installation completed!"
fi

# Accept Xcode license if needed
if ! /usr/bin/xcrun clang 2>&1 | grep -q "invalid active developer path"; then
    echo "📋 Accepting Xcode license..."
    sudo xcodebuild -license accept
fi

echo "✅ Xcode Command Line Tools ready for development"
