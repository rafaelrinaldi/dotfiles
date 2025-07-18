#!/bin/bash

set -euo pipefail

echo "🔑 Setting up Bitwarden authentication..."

if ! bw status | grep -q "authenticated"; then
    echo "Please log in to Bitwarden:"

    sesh=$(bw login --raw)

    if [[ -z "$sesh" ]]; then
        echo "❌ Bitwarden login failed. No session key."
        exit 1
    fi

    export BW_SESSION="$sesh"

    echo "Login successful." # Indicate login was achieved
fi

if ! bw status | grep -q "unlocked"; then
    echo "Please unlock your Bitwarden vault:"

    sesh=$(bw unlock --raw)

    if [[ -z "$sesh" ]]; then
        echo "❌ Bitwarden unlock failed. No session key."
        exit 1
    fi

    export BW_SESSION="${sesh:-$BW_SESSION}"

    echo "Vault unlocked."
fi

echo "✅ Bitwarden authenticated and ready"

if [[ -z "${BW_SESSION:-}" ]]; then
    echo "⚠️ Warning: BW_SESSION variable is not set or empty."
fi
