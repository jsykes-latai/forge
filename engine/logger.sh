#!/usr/bin/env bash

forge_log_init() {
    local profile="$1"
    local timestamp

    timestamp="$(date '+%Y-%m-%d_%H-%M-%S')"

    FORGE_LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/forge/logs"
    FORGE_LOG_FILE="$FORGE_LOG_DIR/${timestamp}-${profile}.log"

    mkdir -p "$FORGE_LOG_DIR"
    touch "$FORGE_LOG_FILE"

    ln -sfn "$(basename "$FORGE_LOG_FILE")" "$FORGE_LOG_DIR/latest.log"

    export FORGE_LOG_DIR
    export FORGE_LOG_FILE

    {
        printf 'Forge %s\n' "$VERSION"
        printf 'Profile: %s\n' "$profile"
        printf 'Started: %s\n' "$(date --iso-8601=seconds)"
        printf '%s\n\n' "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    } >>"$FORGE_LOG_FILE"
}

forge_log_command() {
    local description="$1"
    local status="$2"
    local output_file="$3"

    {
        printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$description"
        printf 'Exit status: %s\n' "$status"
        printf '%s\n' "----------------------------------------"

        if [[ -s "$output_file" ]]; then
            cat "$output_file"
        else
            printf '(no command output)\n'
        fi

        printf '\n'
    } >>"$FORGE_LOG_FILE"
}

forge_log_complete() {
    {
        printf '%s\n' "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        printf 'Completed: %s\n' "$(date --iso-8601=seconds)"
    } >>"$FORGE_LOG_FILE"
}
