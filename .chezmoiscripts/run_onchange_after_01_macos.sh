#!/bin/bash

set -euo pipefail

echo "Configuring macOS settings for software development..."

# Close any open System Preferences panes to prevent conflicts
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Keyboard Settings
###############################################################################

echo "Configuring keyboard settings..."

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Use F1, F2, etc. keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Fast key repeat rate (requires restart)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Dock Settings
###############################################################################

echo "Configuring Dock settings..."

# Move Dock to the right side
defaults write com.apple.dock orientation -string "right"

# Automatically hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove autohide delay
defaults write com.apple.dock autohide-delay -float 0

# Speed up autohide animation
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Make Dock icons smaller (better for side placement)
defaults write com.apple.dock tilesize -int 48

###############################################################################
# Finder Settings
###############################################################################

echo "Configuring Finder settings..."

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Default to column view
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

###############################################################################
# Trackpad Settings
###############################################################################

echo "Configuring trackpad settings..."

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Menu Bar Settings
###############################################################################

echo "Configuring menu bar settings..."

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Show date and time in menu bar
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm a"

###############################################################################
# Security Settings
###############################################################################

echo "Configuring security settings..."

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

###############################################################################
# Development-specific Settings
###############################################################################

echo "Configuring development-specific settings..."

# Enable developer mode for Simulator
sudo DevToolsSecurity -enable

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

###############################################################################
# Wallpaper Settings
###############################################################################

echo "Setting wallpaper..."

# Set wallpaper to grid.heic
if [ -f "$HOME/Pictures/grid.heic" ]; then
    WALLPAPER_ABS="$(cd "$HOME/Pictures" && pwd)/grid.heic"
    osascript <<EOF
tell application "System Events"
    tell every desktop
        set picture to "$WALLPAPER_ABS"
    end tell
end tell
EOF
    echo "✓ Wallpaper set to grid.heic"
fi

###############################################################################
# Apply Changes
###############################################################################

echo "Applying changes..."

# Restart affected applications
for app in "Activity Monitor" \
    "cfprefsd" \
    "Dock" \
    "Finder" \
    "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
done

echo "macOS configuration complete!"
echo ""
echo "You may want to restart your Mac now." 
