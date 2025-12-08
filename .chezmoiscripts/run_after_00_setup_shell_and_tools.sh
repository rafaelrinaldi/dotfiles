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
  # Check if Fisher is installed by checking for the function file
  FISHER_FUNCTIONS_DIR="$HOME/.config/fish/functions"
  if [[ ! -f "$FISHER_FUNCTIONS_DIR/fisher.fish" ]]; then
    echo "Installing Fisher..."
    mkdir -p "$FISHER_FUNCTIONS_DIR"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o "$FISHER_FUNCTIONS_DIR/fisher.fish"
    echo "Fisher installed successfully."
  else
    echo "Fisher already installed."
  fi

  # Update Fisher plugins if fish_plugins file exists
  if [[ -f "$HOME/.config/fish/fish_plugins" ]]; then
    echo "Updating Fisher plugins..."
    # Source Fisher and update plugins, suppressing stderr to avoid:
    # - Wildcard warnings from fisher's temp file handling (harmless)
    # - asdf java version warnings (harmless if java isn't needed)
    fish -c "source $FISHER_FUNCTIONS_DIR/fisher.fish && fisher update 2>/dev/null" || {
      echo "Warning: Failed to update Fisher plugins. This is usually safe to ignore."
      echo "You can manually run 'fisher update' in a Fish shell session."
    }
    echo "Fisher plugins updated."
  else
    echo "No fish_plugins file found, skipping plugin update."
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
