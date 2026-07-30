#!/usr/bin/env bash

GITHUB_INSTALL_PACKAGES=(
    github-cli
)

github_install() {
    if ! sudo -n true 2>/dev/null; then
        printf "          Administrator access required.\n" >/dev/tty
        sudo -v -p "          Password for %u: " </dev/tty >/dev/tty 2>&1
    fi

    sudo pacman \
        --sync \
        --needed \
        --noconfirm \
        "${GITHUB_INSTALL_PACKAGES[@]}"
}
