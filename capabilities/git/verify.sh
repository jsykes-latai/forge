#!/usr/bin/env bash

GIT_REQUIRED_COMMANDS=(
    git
    less
    ssh
    ssh-keygen
    curl
)

GIT_REQUIRED_PACKAGES=(
    ca-certificates
)

git_verify() {
    local command_name
    local package_name

    for command_name in "${GIT_REQUIRED_COMMANDS[@]}"; do
        if ! command -v "$command_name" >/dev/null 2>&1; then
            echo "Required command not found: $command_name" >&2
            return 1
        fi
    done

    for package_name in "${GIT_REQUIRED_PACKAGES[@]}"; do
        if ! pacman -Q "$package_name" >/dev/null 2>&1; then
            echo "Required package not installed: $package_name" >&2
            return 1
        fi
    done

    return 0
}
