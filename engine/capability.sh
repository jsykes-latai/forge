load_capability() {

    local capability="$1"

    local capability_dir="$FORGE_ROOT/capabilities/$capability"

    if [[ ! -d "$capability_dir" ]]; then
        forge_error "Capability not found: $capability"
        return 1
    fi

    source "$capability_dir/capability.sh"
    source "$capability_dir/install.sh"
    source "$capability_dir/verify.sh"

}

execute_capability() {

    local capability="$1"

    load_capability "$capability" || return 1

    forge_step "$CAPABILITY_NAME"
    echo

    forge_check "Preparing..." capability_install || {
        forge_error "Preparation failed"
        return 1
    }

    forge_check "Confirming..." capability_verify || {
        forge_error "Verification failed"
        return 1
    }

    echo
    forge_success "Ready"

}
