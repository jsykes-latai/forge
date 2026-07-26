#!/usr/bin/env bash

execute_capability() {

    CAPABILITY="$1"

    CAPABILITY_DIR="$FORGE_ROOT/capabilities/$CAPABILITY"

    if [[ ! -d "$CAPABILITY_DIR" ]]; then
        forge_error "Capability not found: $CAPABILITY"
        return 1
    fi


    source "$CAPABILITY_DIR/capability.sh"


    forge_step "$CAPABILITY_NAME"


    source "$CAPABILITY_DIR/install.sh"
    source "$CAPABILITY_DIR/verify.sh"


    if capability_install; then
        forge_success "$CAPABILITY_NAME installed"
    else
        forge_error "$CAPABILITY_NAME installation failed"
        return 1
    fi


    if capability_verify; then
        forge_success "$CAPABILITY_NAME verified"
    else
        forge_error "$CAPABILITY_NAME verification failed"
        return 1
    fi
}
