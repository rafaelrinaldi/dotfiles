#!/bin/bash

set -euo pipefail

echo "Installing packages from Brewfile..."

export HOMEBREW_CASK_OPTS=--no-quarantine

if [[ -f "$HOME/Brewfile" ]]; then
  brew bundle --file="$HOME/Brewfile"
  echo "All packages installed from Brewfile."
else
  echo "Brewfile not found at $HOME/Brewfile."
fi
