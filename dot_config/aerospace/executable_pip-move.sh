#!/bin/bash
# Ensure Picture in Picture always floats
# https://github.com/nikitabobko/AeroSpace/issues/2#issuecomment-3023036984

set -e

# Get current workspace
current_workspace=$(aerospace list-workspaces --focused)

# Move PiP windows to current workspace (handles both "Picture-in-Picture" and "Picture in Picture")
aerospace list-windows --all | grep -E "(Picture-in-Picture|Picture in Picture)" | awk '{print $1}' | while read window_id; do
    if [ -n "$window_id" ]; then
        aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
    fi
done
