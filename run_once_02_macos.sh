#!/bin/bash

echo "Setting up macOS..."

# Xcode
echo "Checking for Xcode Command Line Tools..."
if ! xcode-select --print-path &> /dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    # Wait until the user has installed the tools
    read -p "Press any key to continue once Xcode Command Line Tools installation is complete..."
else
    echo "Xcode Command Line Tools already installed."
fi

# macOS defaults
echo "Configuring macOS system defaults..."

# General UI/UX
# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Keyboard
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
# Set a shorter initial key repeat delay
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Trackpad/Mouse
# Enable tap to click for the trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Increase trackpad tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3.0

# Disable natural scrolling (if preferred by developers)
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Finder
# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# New Finder windows open to Home folder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Restart affected applications for changes to take effect
echo "Restarting affected applications for changes to take effect..."
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "$app" &> /dev/null
done

echo "macOS Developer Setup Script finished!"
