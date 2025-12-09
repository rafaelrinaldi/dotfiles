#!/bin/bash
# Bootstrap script for setting up dotfiles on a fresh machine
# Usage: curl -fsLS https://rinaldi.io/dotfiles -o /tmp/install.sh && bash /tmp/install.sh

set -euo pipefail

echo "🚀 Bootstrapping dotfiles..."

# ------------------------------------------------------------------------------
# Helper: Source Homebrew
# ------------------------------------------------------------------------------
source_brew() {
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

# ------------------------------------------------------------------------------
# Helper: Source asdf
# ------------------------------------------------------------------------------
source_asdf() {
  if [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
    . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
  elif [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    . "$HOME/.asdf/asdf.sh"
  fi
}

# ------------------------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------------------------
source_brew

if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  source_brew
fi

# Add to shell profile if not already there
if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

echo "✓ Homebrew ready"

# ------------------------------------------------------------------------------
# chezmoi
# ------------------------------------------------------------------------------
if ! command -v chezmoi &>/dev/null; then
  echo "📦 Installing chezmoi..."
  brew install chezmoi
fi

echo "✓ chezmoi ready"

# ------------------------------------------------------------------------------
# asdf (version manager)
# ------------------------------------------------------------------------------
source_asdf

if ! command -v asdf &>/dev/null; then
  echo "📦 Installing asdf..."
  brew install asdf
  source_asdf
fi

echo "✓ asdf ready"

# ------------------------------------------------------------------------------
# Node.js (via asdf)
# ------------------------------------------------------------------------------
if ! asdf plugin list 2>/dev/null | grep -q "nodejs"; then
  echo "📦 Adding asdf nodejs plugin..."
  asdf plugin add nodejs
fi

if ! command -v node &>/dev/null; then
  echo "📦 Installing Node.js..."
  asdf install nodejs latest
  asdf set nodejs latest --home
  asdf reshim nodejs
fi

echo "✓ Node.js ready"

# ------------------------------------------------------------------------------
# Bitwarden CLI (needed for chezmoi to fetch secrets)
# ------------------------------------------------------------------------------
if ! command -v bw &>/dev/null; then
  echo "📦 Installing Bitwarden CLI..."
  npm install -g @bitwarden/cli
  asdf reshim nodejs
fi

echo "✓ Bitwarden CLI ready"

# ------------------------------------------------------------------------------
# Bitwarden authentication
# ------------------------------------------------------------------------------
echo ""
echo "🔐 Bitwarden authentication required for secrets..."
echo ""

# Check if already logged in
BW_STATUS=$(bw status 2>/dev/null | grep -o '"status":"[^"]*"' | cut -d'"' -f4 || echo "unauthenticated")

if [[ "$BW_STATUS" == "unauthenticated" ]]; then
  echo "Please login to Bitwarden:"
  bw login
  BW_STATUS="locked"
fi

if [[ "$BW_STATUS" == "locked" ]]; then
  echo "Please unlock your Bitwarden vault:"
  export BW_SESSION=$(bw unlock --raw)
fi

if [[ -z "${BW_SESSION:-}" ]]; then
  echo "⚠️  BW_SESSION not set. Please run: export BW_SESSION=\$(bw unlock --raw)"
  exit 1
fi

# ------------------------------------------------------------------------------
# chezmoi init + apply
# ------------------------------------------------------------------------------
echo ""
echo "🏠 Running chezmoi init..."
echo ""

chezmoi init --apply rafaelrinaldi/dotfiles

echo ""
echo "✅ Done! Please restart your terminal to use Fish shell."
echo ""
