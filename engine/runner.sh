# Coordinates everything. Read Profile -> For Each module (Execute Module) -> Done

#!/usr/bin/env bash

ENGINE_DIR="$(dirname "${BASH_SOURCE[0]}")"
FORGE_ROOT="$(dirname "$ENGINE_DIR")"

source "$ENGINE_DIR/status.sh"
source "$ENGINE_DIR/logger.sh"
source "$ENGINE_DIR/ui.sh"
source "$ENGINE_DIR/profile.sh"
source "$ENGINE_DIR/capability.sh"

forge_execute_profile() {
    PROFILE="$1"

    forge_log_init "$PROFILE"

    forge_header "$PROFILE"

    forge_phase "Loading profile..."

    load_profile "$PROFILE" || return $?

    forge_success "Profile loaded: $PROFILE"

    forge_phase "Capabilities detected..."

    for capability in "${CAPABILITIES[@]}"; do
        forge_step "$capability"
    done

    forge_phase "Building capabilities..."

    first=true

    for capability in "${CAPABILITIES[@]}"; do
        if ! $first; then
            echo
        fi
        first=false
        
        forge_execute_capability "$capability" || return $?
    done

    forge_log_complete

    echo
    forge_complete
}
