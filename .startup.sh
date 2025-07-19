#!/bin/bash

set -euo pipefail

echo "Starting startup script..."

# Install Xcode

echo "Checking for Xcode Command Line Tools..."

if xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools are already installed."
else
  echo "Xcode Command Line Tools not found. Installing..."

  xcode-select --install

  echo "Click 'Install' in the pop-up window and agree to the terms."
  echo "Waiting for Xcode Command Line Tools installation to complete..."

  # Loop until xcode-select --install finishes
  while ! xcode-select -p &>/dev/null; do
    sleep 5
  done

  echo "Xcode Command Line Tools installation complete."
fi

# Install Homebrew

echo "Checking for Homebrew..."

if command -v brew &>/dev/null; then
  echo "Homebrew is already installed."
else
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for zsh
  if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo "Added Homebrew to ~/.zprofile. Please source your .zprofile or restart your terminal."
  else
    echo "Homebrew shellenv already configured in ~/.zprofile."
  fi

  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "Homebrew installation complete."
fi

# Install latest Node.js via asdf

echo "Checking for asdf..."

if command -v asdf &>/dev/null; then
  echo "asdf is already installed."
else
  echo "asdf not found. Installing via Homebrew..."

  brew install asdf

  echo "Adding asdf to Zsh configuration..."

  echo '. "$(brew --prefix asdf)/libexec/asdf.sh"' > ~/.zshrc

  # Source asdf immediately for the current session
  . "$(brew --prefix asdf)/libexec/asdf.sh"

  echo "asdf installation complete."
fi

echo "Installing Node.js via asdf..."

if asdf plugin list | grep -q "nodejs"; then
  echo "asdf nodejs plugin already added."
else
  echo "Adding asdf nodejs plugin..."
  asdf plugin add nodejs
  echo "asdf nodejs plugin added."
fi

echo "Installing latest Node.js via asdf..."

asdf install nodejs latest
asdf set nodejs latest --home
asdf reshim nodejs

# Verify Node.js installation
if command -v node &>/dev/null; then
  echo "Node.js installed successfully. Version: $(node -v)"
else
  echo "Node.js installation failed. Please check the logs."
fi

# Install bw via npm

echo "Checking for 'bw'..."

if command -v bw &>/dev/null; then
  echo "'bw' is already installed globally."
else
  echo "'bw' not found. Installing globally via npm..."

  npm install -g @bitwarden/cli

  if command -v bw &>/dev/null; then
    echo "'bw' installed successfully. Version: $(bw --version)"
  else
    echo "'bw' installation failed. Please check the logs."
  fi
fi

echo "Startup script finished."
