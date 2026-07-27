#!/usr/bin/env bash

SHELL_COMMANDS=(
    zsh
    starship
    eza
    bat
    fd
    rg
    fzf
    zoxide
    btop
)

shell_verify() {
    local command_name

    for command_name in "${SHELL_COMMANDS[@]}"; do
        if ! command -v "$command_name" >/dev/null 2>&1; then
            echo "Required command not found: $command_name" >&2
            return 1
        fi
    done

    return 0
}
