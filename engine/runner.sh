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
    log_info "Building capabilities:"

    for capability in "${CAPABILITIES[@]}"; do

        echo
        echo "  [$capability]"

        CAPABILITY_DIR="$(dirname "${BASH_SOURCE[0]}")/../capabilities/$capability"

        source "$CAPABILITY_DIR/capability.sh"
        source "$CAPABILITY_DIR/install.sh"
        source "$CAPABILITY_DIR/verify.sh"

        install

        if verify; then
            log_success "$capability ready"
        else
            log_error "$capability failed verification"
            exit 1
        fi

    done

    echo
    log_success "Build complete"

}
