#!/bin/bash

set -euo pipefail

echo "Performing Bitwarden auth..."

bw login
export BW_SESSION=$(bw unlock --raw)

echo "Bitwarden auth complete."
