#!/usr/bin/env bash

set -e

echo "⚒️  Forge bootstrap starting..."

echo "Installing packages..."
sudo pacman -S --needed - < packages.txt

echo "Installing configs..."

cp config/zsh/.zshrc ~/.zshrc
cp config/starship/starship.toml ~/.config/starship.toml
cp config/git/.gitconfig ~/.gitconfig

echo "Forge bootstrap complete."
