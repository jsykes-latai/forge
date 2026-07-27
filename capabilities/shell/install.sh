#!/usr/bin/env bash

SHELL_PACKAGES=(
    zsh
    starship
    eza
    bat
    fd
    ripgrep
    fzf
    zoxide
    btop
)

shell_install() {
    if ! sudo -n true 2>/dev/null; then
        printf "          Administrator access required.\n" >/dev/tty
        sudo -v -p "          Password for %u: " </dev/tty >/dev/tty 2>&1
    fi

    sudo pacman \
        --sync \
        --needed \
        --noconfirm \
        "${SHELL_PACKAGES[@]}"
}
