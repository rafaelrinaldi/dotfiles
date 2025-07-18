#!/bin/bash

set -euo pipefail

echo "🔐 Installing Bitwarden CLI..."

if ! command -v bw &>/dev/null; then
    npm install -g @bitwarden/cli
    echo "✅ Bitwarden CLI installed"
else
    echo "✅ Bitwarden CLI already installed"
fi
