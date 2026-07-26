# Coordinates everything. Read Profile -> For Each module (Execute Module) -> Done

#!/usr/bin/env bash

ENGINE_DIR="$(dirname "${BASH_SOURCE[0]}")"

source "$ENGINE_DIR/logger.sh"
source "$ENGINE_DIR/profile.sh"


build_profile() {

    PROFILE="$1"

    echo
    echo "⚒ Forge"
    echo
    log_info "Loading profile: $PROFILE"

    load_profile "$PROFILE"

    echo

    log_success "Profile loaded"
    log_info "Capabilities detected:"

    for capability in "${CAPABILITIES[@]}"; do
        echo "      - $capability"
    done

    echo
    log_success "Build complete"

}
