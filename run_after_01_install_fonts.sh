#!/bin/bash

set -euo pipefail

echo "Installing fonts..."

FONT_FILENAME="TX-02.zip"
FONT_FILENAME_BASE=$(basename $FONT_FILENAME .zip)
FONTS_DIR="$HOME/Library/Fonts"
TEMP_DIR=$(mktemp -d)
ITEM_ID=$(bw get item chezmoi | jq -r ".id")
DOWNLOAD_TARGET="$TEMP_DIR/$FONT_FILENAME"

# Get the attachment from Bitwarden
bw get attachment $FONT_FILENAME --itemid $ITEM_ID --output $TEMP_DIR/$FONT_FILENAME

if [ $? -ne 0 ]; then
    echo "Failed to download font '$FONT_FILENAME'. Cleaning up temp directory and exiting."
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "Font downloaded to: $TEMP_DIR/$FONT_FILENAME"

echo "Unzipping '$TEMP_DIR/$FONT_FILENAME'..."

pushd "$TEMP_DIR" > /dev/null
unzip -o $FONT_FILENAME

if [ $? -ne 0 ]; then
    echo "Failed to unzip '$FONT_FILENAME'. Cleaning up and exiting."
    popd > /dev/null
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "File unzipped successfully in: $TEMP_DIR/$FONT_FILENAME_BASE"

popd > /dev/null

echo "Installing fonts to $FONTS_DIR..."
cp -r $TEMP_DIR/$FONT_FILENAME_BASE/*.otf $FONTS_DIR/

echo "Clearing macOS font caches..."
sudo atsutil databases -remove

rm -rf "$TEMP_DIR"

echo "Font installation done."
