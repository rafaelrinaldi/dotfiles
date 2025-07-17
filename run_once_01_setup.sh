#!/bin/bash

set -euo pipefail

echo "🚀 Starting system setup..."

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for this session
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "✅ Homebrew already installed"
fi

# Disable quarantine for casks
export HOMEBREW_CASK_OPTS=--no-quarantine

# Install packages via Brewfile
if [[ -f "$HOME/Brewfile" ]]; then
  echo "📦 Installing packages from Brewfile..."
  brew bundle --file="$HOME/Brewfile"
else
  echo "⚠️  No Brewfile found, skipping package installation"
fi

# Set Fish as the default shell
if command -v fish &>/dev/null; then
  FISH_PATH=$(which fish)

  # Add fish to /etc/shells if not already there
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "🐟 Adding Fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi

  # Change default shell if not already fish
  if [[ "$SHELL" != "$FISH_PATH" ]]; then
    echo "🐟 Setting Fish as default shell..."
    chsh -s "$FISH_PATH"
  else
    echo "✅ Fish is already the default shell"
  fi
else
  echo "⚠️  Fish not found, skipping shell setup"
fi

# Install Fisher for Fish if not already installed
if command -v fish &>/dev/null; then
  if ! fish -c "command -v fisher" &>/dev/null; then
    echo "🎣 Installing Fisher..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
  else
    echo "✅ Fisher already installed"
  fi

  # Update Fisher plugins if fish_plugins file exists
  if [[ -f "$HOME/.config/fish/fish_plugins" ]]; then
    echo "🎣 Updating Fisher plugins..."
    fish -c "fisher update"
  fi
else
  echo "⚠️  Fish not available, skipping Fisher setup"
fi

# Install TPM for Tmux if not already installed
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "📺 Installing TPM (Tmux Plugin Manager)..."
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "✅ TPM already installed"
fi

# ASDF setup
if command -v asdf &>/dev/null; then
  echo "📦 Setting up ASDF plugins..."

  # Add nodejs plugin if not already added
  if ! asdf plugin list | grep -q nodejs; then
    echo "  Adding nodejs plugin..."
    asdf plugin add nodejs
  fi

  # Add ruby plugin if not already added
  if ! asdf plugin list | grep -q ruby; then
    echo "  Adding ruby plugin..."
    asdf plugin add ruby
  fi

  # Install versions from .tool-versions if it exists
  if [[ -f "$HOME/.tool-versions" ]]; then
    echo "  Installing ASDF packages from .tool-versions..."
    asdf install
  fi
else
  echo "⚠️  ASDF not found, skipping version management setup"
fi

# Install Bitwarden Secret Manager CLI (bws)
if ! command -v bws &>/dev/null; then
  echo "🔐 Installing Bitwarden Secret Manager CLI..."
  curl -fsSL https://bws.bitwarden.com/install | sh
else
  echo "✅ Bitwarden Secret Manager CLI already installed"
fi

echo "🎉 System setup complete!"
echo ""
echo "Next steps:"
echo "  • Restart your terminal to use Fish shell"
echo "  • Run 'tmux' and press prefix + I to install tmux plugins"
echo "  • Configure your development tools as needed"
