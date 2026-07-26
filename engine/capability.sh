####################################################################
### Find the capability and determine where the capabilty lives. ###
####################################################################

forge_find_capability() {

    local capability="$1"
    local capability_dir="$FORGE_ROOT/capabilities/$capability"

    [[ -d "$capability_dir" ]] || return 1

    echo "$capability_dir"
}


#############################################################################
### Validate the capabilty and verify that it satisfies Forge's contract. ###
#############################################################################

forge_validate_capability() {

    local capability_dir="$1"

    local required_files=(
        capability.sh
        install.sh
        verify.sh
    )

    for file in "${required_files[@]}"; do
        if [[ ! -f "$capability_dir/$file" ]]; then
            forge_error "Missing $file"
            return 1
        fi
    done
}


#########################################
### Validate the capability interface ###
#########################################

forge_validate_capability_interface() {

    declare -F capability_install >/dev/null || {
        forge_error "Capability does not define capability_install()"
        return 1
    }

    declare -F capability_verify >/dev/null || {
        forge_error "Capability does not define capability_verify()"
        return 1
    }

    [[ -n "${CAPABILITY_NAME:-}" ]] || {
        forge_error "Capability does not define CAPABILITY_NAME"
        return 1
    }
}


###############################################
### Load the capability. Boring and simple. ###
###############################################

forge_load_capability() {

    local capability="$1"

    local capability_dir

    capability_dir="$(forge_find_capability "$capability")" || {
        forge_error "Capability not found: $capability"
        return 1
    }

    forge_validate_capability "$capability_dir" || return 1

    source "$capability_dir/capability.sh"
    source "$capability_dir/install.sh"
    source "$capability_dir/verify.sh"

    forge_validate_capability_interface || return 1
}


##############################
### Execute the capability ###
##############################

forge_execute_capability() {

    local capability="$1"

    forge_load_capability "$capability" || return 1

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
