#!/usr/bin/env bash

set -e

echo "⚒️ Checking Forge requirements..."

if ! command -v pacman >/dev/null; then
    echo "Error: Forge requires Arch Linux."
    exit 1
fi

echo "✓ Arch Linux detected"
