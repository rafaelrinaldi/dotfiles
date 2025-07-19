#!/bin/bash

set -euo pipefail

# Set Fish as the default shell
if command -v fish &>/dev/null; then
  FISH_PATH=$(which fish)

  # Add fish to /etc/shells if not already there
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "Adding Fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi

  # Change default shell if not already fish
  if [[ "$SHELL" != "$FISH_PATH" ]]; then
    echo "Setting Fish as default shell..."
    chsh -s "$FISH_PATH"
  else
    echo "Fish is already the default shell"
  fi
else
  echo "Fish not found, skipping shell setup"
fi

# Install Fisher for Fish if not already installed
if command -v fish &>/dev/null; then
  if ! fish -c "command -v fisher" &>/dev/null; then
    echo "Installing Fisher..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
  else
    echo "Fisher already installed."
  fi

  # Update Fisher plugins
  if [[ -f "$HOME/.config/fish/fish_plugins" ]]; then
    echo "Updating Fisher plugins..."
    fish -c "fisher update"
  fi
else
  echo "Fish not available, skipping Fisher setup."
fi

# Install TPM for tmux if not already installed
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "Installing TPM..."
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "TPM already installed."
fi

echo "System setup complete!"
echo ""
echo "Next steps:"
echo "  • Restart your terminal to use Fish shell"
echo "  • Run 'tmux' and press prefix + I to install tmux plugins"
