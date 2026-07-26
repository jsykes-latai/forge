#!/usr/bin/env bash

capability_install() {

    echo "      Installing shell capability..."

    echo "      Checking zsh..."

    if command -v zsh >/dev/null 2>&1; then
        echo "      ✓ zsh already installed"
    else
        echo "      Installing zsh..."
        sudo pacman -S --needed --noconfirm zsh
    fi

}
