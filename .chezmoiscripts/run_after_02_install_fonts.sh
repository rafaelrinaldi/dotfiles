#!/bin/bash
# vim: ft=sh :

set -euo pipefail

FONT_FILENAME="TX-02-Variable.zip"
FONT_FILENAME_BASE=$(basename "$FONT_FILENAME" .zip)
FONTS_DIR="$HOME/Library/Fonts"

# Check if fonts are already installed (early exit)
if ls "${FONTS_DIR}/${FONT_FILENAME_BASE}"*.otf &>/dev/null; then
  echo "Font '${FONT_FILENAME_BASE}' appears to be already installed. Skipping installation."
  exit 0
fi

echo "Installing fonts..."

# Source asdf if available (needed for bw command)
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  source "$HOME/.asdf/asdf.sh"
elif [[ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]]; then
  source "/opt/homebrew/opt/asdf/libexec/asdf.sh"
fi

# Check if bw is available
if ! command -v bw &>/dev/null; then
  echo "Warning: 'bw' (Bitwarden CLI) is not available. Skipping font installation."
  echo "You can install fonts manually later or ensure 'bw' is in your PATH."
  exit 0
fi

TEMP_DIR=$(mktemp -d)

# Check if Bitwarden vault is unlocked and user is logged in
BW_STATUS_JSON=$(bw status 2>/dev/null || echo '{"status":"unknown"}')
BW_STATUS=$(echo "$BW_STATUS_JSON" | jq -r '.status' 2>/dev/null || echo "unknown")
BW_LOGGED_IN=$(echo "$BW_STATUS_JSON" | jq -r '.userId' 2>/dev/null || echo "")

if [[ -z "$BW_LOGGED_IN" || "$BW_LOGGED_IN" == "null" || "$BW_STATUS" != "unlocked" ]]; then
  echo "Warning: Bitwarden vault is not unlocked or user not logged in (status: ${BW_STATUS:-unknown}). Skipping font installation."
  echo "Please login and unlock your Bitwarden vault: 'bw login' and 'bw unlock'"
  rm -rf "$TEMP_DIR"
  exit 0
fi

# Get item ID from Bitwarden - try by name first, then by search
ITEM_ID=""
# Try direct get first
ITEM_OUTPUT=$(bw get item chezmoi 2>&1)
if echo "$ITEM_OUTPUT" | jq -e '.id' >/dev/null 2>&1; then
  ITEM_ID=$(echo "$ITEM_OUTPUT" | jq -r '.id')
else
  # If direct get fails, try searching
  SEARCH_RESULT=$(bw list items --search chezmoi 2>/dev/null | jq -r '.[0].id' 2>/dev/null || echo "")
  if [[ -n "$SEARCH_RESULT" && "$SEARCH_RESULT" != "null" ]]; then
    ITEM_ID="$SEARCH_RESULT"
  fi
fi

if [[ -z "$ITEM_ID" || "$ITEM_ID" == "null" ]]; then
  echo "Warning: Could not find Bitwarden item 'chezmoi'. Skipping font installation."
  echo "Make sure the item exists and you have access to it."
  rm -rf "$TEMP_DIR"
  exit 0
fi

echo "Downloading encrypted font file..."

# Get the attachment from Bitwarden
if ! bw get attachment "$FONT_FILENAME" --itemid "$ITEM_ID" --output "$TEMP_DIR/$FONT_FILENAME" 2>/dev/null; then
  echo "Warning: Failed to download font '$FONT_FILENAME' from Bitwarden. Skipping installation." >&2
  rm -rf "$TEMP_DIR"
  exit 0
fi

echo "Font downloaded to: $TEMP_DIR/$FONT_FILENAME"

echo "Unzipping '$TEMP_DIR/$FONT_FILENAME'..."

pushd "$TEMP_DIR" >/dev/null
unzip -o "$FONT_FILENAME"

if [ $? -ne 0 ]; then
  echo "ERROR: Failed to unzip '$FONT_FILENAME'. Cleaning up and exiting." >&2
  popd >/dev/null
  rm -rf "$TEMP_DIR"
  exit 1
fi

popd >/dev/null

echo "Installing fonts to $FONTS_DIR..."

# Create the fonts directory if it doesn't exist
mkdir -p "$FONTS_DIR"

# Copy all OTF/TTF files (unzip extracts to current dir, not a subdirectory)
find "$TEMP_DIR" -name "*.otf" -o -name "*.ttf" | while read -r font; do
  cp "$font" "$FONTS_DIR/"
  echo "Installed: $(basename "$font")"
done

echo "Clearing macOS font caches..."
sudo atsutil databases -remove

rm -rf "$TEMP_DIR"

echo "Font installation done."
