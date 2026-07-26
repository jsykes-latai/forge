#!/usr/bin/env bash

forge_header() {
    echo
    echo "⚒ Forge $VERSION"
    echo
    echo "Building $1"
    echo
}

forge_phase() {
    echo
    echo "  $1"
}

forge_step() {
    echo "      $1"
}

forge_info() {
    echo "  [INFO] $1"
}

forge_success() {
    echo "  ✓ $1"
}

forge_warning() {
    echo
    echo "  ⚠ $1"
    echo
}

forge_error() {
    echo
    echo "  ✗ $1"
    echo
}

forge_action() {
    printf "          %-20s " "$1"
}

forge_check() {
    local message="$1"
    shift

    forge_action "$message"

    "$@"
    local status=$?

    if (( status == 0 )); then
        echo "✓"
    else
        echo "✗"
    fi

    return "$status"
}

forge_complete() {
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    echo "⚒ Forge complete."
    echo
    echo "Welcome Home."
    echo
}

