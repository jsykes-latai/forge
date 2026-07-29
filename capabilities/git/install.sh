#!/usr/bin/env bash

GIT_INSTALL_PACKAGES=(
    git
    less
    openssh
    curl
    ca-certificates
)

git_install() {
    if ! sudo -n true 2>/dev/null; then
        printf "          Administrator access required.\n" >/dev/tty
        sudo -v -p "          Password for %u: " </dev/tty >/dev/tty 2>&1
    fi

    sudo pacman \
        --sync \
        --needed \
        --noconfirm \
        "${GIT_INSTALL_PACKAGES[@]}"
}
