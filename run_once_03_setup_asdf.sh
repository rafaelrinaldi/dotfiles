#!/bin/bash

set -euo pipefail

echo "🔧 Setting up ASDF and Node.js..."

# Source ASDF (installed via Homebrew)
if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
    source /opt/homebrew/opt/asdf/libexec/asdf.sh
elif [[ -f "/usr/local/opt/asdf/libexec/asdf.sh" ]]; then
    source /usr/local/opt/asdf/libexec/asdf.sh
else
    echo "❌ ASDF not found. Make sure it's in your Brewfile."
    exit 1
fi

echo "Download and install latest Node.js version..."

asdf plugin add nodejs
asdf install

asdf install nodejs latest
asdf set nodejs latest --home

# Verify installation
if command -v node &>/dev/null; then
    echo "✅ Node.js $(node --version) installed"
else
    echo "❌ Node.js installation failed"
    exit 1
fi
