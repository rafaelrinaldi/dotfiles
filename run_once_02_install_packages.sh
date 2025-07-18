#!/bin/bash

set -euo pipefail

echo "📦 Installing packages from Brewfile..."

# Ensure Homebrew is in PATH
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

export HOMEBREW_CASK_OPTS=--no-quarantine

# By now, chezmoi has applied Brewfile.tmpl to ~/Brewfile
if [[ -f "$HOME/Brewfile" ]]; then
    brew bundle --file="$HOME/Brewfile"
    echo "✅ Packages installed"
else
    echo "❌ Brewfile not found at $HOME/Brewfile"
    exit 1
fi
