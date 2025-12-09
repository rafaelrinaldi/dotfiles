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
  # Ensure shims are in PATH
  export PATH="$HOME/.asdf/shims:$PATH"
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

# Get latest Node.js version and install if needed
NODEJS_VERSION=$(asdf latest nodejs)
if ! asdf list nodejs 2>/dev/null | grep -q "$NODEJS_VERSION"; then
  echo "📦 Installing Node.js $NODEJS_VERSION..."
  asdf install nodejs "$NODEJS_VERSION"
fi

# Set global Node.js version (must use actual version number, not "latest")
echo "nodejs $NODEJS_VERSION" > ~/.tool-versions
asdf reshim nodejs

# Re-source asdf to pick up new shims
source_asdf

# Verify node works
if ! node -v &>/dev/null; then
  echo "❌ Node.js installation failed"
  echo "DEBUG: PATH=$PATH"
  echo "DEBUG: tool-versions=$(cat ~/.tool-versions)"
  exit 1
fi

echo "✓ Node.js ready ($(node -v))"

# ------------------------------------------------------------------------------
# Bitwarden CLI (needed for chezmoi to fetch secrets)
# ------------------------------------------------------------------------------
echo "📦 Installing Bitwarden CLI..."
npm install -g @bitwarden/cli
asdf reshim nodejs

# Re-source asdf to pick up new shims
source_asdf

# Verify bw works
if ! bw --version &>/dev/null; then
  echo "❌ Bitwarden CLI installation failed"
  echo "DEBUG: PATH=$PATH"
  echo "DEBUG: which bw=$(which bw 2>&1 || echo 'not found')"
  exit 1
fi

echo "✓ Bitwarden CLI ready ($(bw --version))"

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
# Machine profile selection
# ------------------------------------------------------------------------------
echo ""
echo "🖥️  Select machine profile:"
echo "  1) personal"
echo "  2) work"
echo ""
read -p "Enter choice [1-2]: " profile_choice

case "$profile_choice" in
  1) export CHEZMOI_MACHINE_PROFILE="personal" ;;
  2) export CHEZMOI_MACHINE_PROFILE="work" ;;
  *)
    echo "Invalid choice. Defaulting to 'personal'."
    export CHEZMOI_MACHINE_PROFILE="personal"
    ;;
esac

echo "Using profile: $CHEZMOI_MACHINE_PROFILE"

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
