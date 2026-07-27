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
    local action_message="$1"
    local success_message="$2"
    local failure_message="$3"
    local output_file
    local status

    shift 3

    output_file="$(mktemp)"

    echo "          $action_message"

    if "$@" >"$output_file" 2>&1; then
        status=0
    else
        status=$?
    fi

    forge_log_command "$action_message" "$status" "$output_file"

    if (( status == 0 )); then
        printf "          %-20s ✓\n" "$success_message"
    else
        printf "          %-20s ✗\n" "$failure_message"
        echo
        echo "          Command output:"

        if [[ -s "$output_file" ]]; then
            tail -n 12 "$output_file" |
                sed 's/^/              /'
        else
            echo "              No diagnostic output was produced."
        fi

        echo
        echo "          Full log:"
        echo "              $FORGE_LOG_FILE"
    fi

    rm -f "$output_file"

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

