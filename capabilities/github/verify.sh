#!/usr/bin/env bash

GITHUB_REQUIRED_COMMANDS=(
    gh
)

github_verify() {
    local command_name

    for command_name in "${GITHUB_REQUIRED_COMMANDS[@]}"; do
        if ! command -v "$command_name" >/dev/null 2>&1; then
            echo "Required command not found: $command_name" >&2
            return 1
        fi
    done

    return 0
}
