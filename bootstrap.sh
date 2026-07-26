#!/usr/bin/env bash

set -e

echo "⚒️ Forge bootstrap starting..."

./scripts/check-system.sh
./scripts/install-packages.sh
./scripts/install-tools.sh
./scripts/link-configs.sh

echo "⚒️ Forge bootstrap complete."
