#!/bin/bash
# Ensures prerequisites are installed (idempotent)
# Note: Initial bootstrap is handled by install.sh - this runs on subsequent chezmoi apply

set -euo pipefail

# Source asdf if available
if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
elif [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  . "$HOME/.asdf/asdf.sh"
fi

# Ensure Homebrew is in PATH
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ------------------------------------------------------------------------------
# Verify core tools are present
# ------------------------------------------------------------------------------

missing_tools=()

command -v brew &>/dev/null || missing_tools+=("homebrew")
command -v asdf &>/dev/null || missing_tools+=("asdf")
command -v node &>/dev/null || missing_tools+=("nodejs")
command -v bw &>/dev/null || missing_tools+=("bitwarden-cli")

if [[ ${#missing_tools[@]} -gt 0 ]]; then
  echo "⚠️  Missing tools: ${missing_tools[*]}"
  echo "   Run the bootstrap script first:"
  echo "   curl -fsLS https://raw.githubusercontent.com/rafaelrinaldi/dotfiles/main/install.sh | bash"
  exit 1
fi

# ------------------------------------------------------------------------------
# Ensure Node.js is set up correctly via asdf
# ------------------------------------------------------------------------------

# Add nodejs plugin if missing
if ! asdf plugin list 2>/dev/null | grep -q "nodejs"; then
  echo "Adding asdf nodejs plugin..."
  asdf plugin add nodejs
fi

# Install Node.js if not available
if ! asdf list nodejs &>/dev/null; then
  echo "Installing Node.js via asdf..."
  asdf install nodejs latest
  asdf set nodejs latest --home
  asdf reshim nodejs
fi

echo "✓ Prerequisites verified"
