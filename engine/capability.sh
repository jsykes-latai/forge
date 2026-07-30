#!/usr/bin/env bash

###########################
### Capability contract ###
###########################


##########################################################################
### Every Forge capability must provide these functions and variables. ###
##########################################################################

FORGE_REQUIRED_CAPABILITY_FUNCTIONS=(
    capability_install
    capability_verify
)

FORGE_REQUIRED_CAPABILITY_VARIABLES=(
    CAPABILITY_ID
    CAPABILITY_NAME
    CAPABILITY_DESCRIPTION
)


####################################################################
### Find the capability and determine where the capabilty lives. ###
####################################################################

forge_find_capability() {

    local capability="$1"
    local capability_dir="$FORGE_ROOT/capabilities/$capability"

    [[ -d "$capability_dir" ]] || return "$FORGE_CAPABILITY_NOT_FOUND"

    echo "$capability_dir"
}


######################################
### Validate the capabilty package ###
######################################

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
            return "$FORGE_CAPABILITY_INVALID"
        fi
    done
}


#########################################
### Validate the capability interface ###
#########################################

forge_validate_capability_interface() {
    local expected_capability="$1"

    if [[ "$CAPABILITY_ID" != "$expected_capability" ]]; then
        forge_error "Capability ID mismatch"
        forge_error "Expected: $expected_capability"
        forge_error "Declared: $CAPABILITY_ID"
        return "$FORGE_CAPABILITY_INVALID"
    fi

    for function in "${FORGE_REQUIRED_CAPABILITY_FUNCTIONS[@]}"; do

        if ! declare -F "$function" >/dev/null; then
            forge_error "Missing required function: $function"
            return "$FORGE_CAPABILITY_INVALID"
        fi

    done

    if ! declare -p CAPABILITY_DEPENDENCIES &>/dev/null; then
        forge_error "Missing required variable: CAPABILITY_DEPENDENCIES"
        return "$FORGE_CAPABILITY_INVALID"
    fi

    if [[ "$(declare -p CAPABILITY_DEPENDENCIES)" != "declare -a"* ]]; then
        forge_error "CAPABILITY_DEPENDENCIES must be an indexed array"
        return "$FORGE_CAPABILITY_INVALID"
    fi

}


###############################################
### Load the capability. Boring and simple. ###
###############################################

forge_load_capability() {

    local capability="$1"

    local capability_dir

    capability_dir="$(forge_find_capability "$capability")" || {
        forge_error "Capability not found: $capability"
        return "$FORGE_CAPABILITY_NOT_FOUND"
    }

    forge_validate_capability "$capability_dir" || return $?

    unset CAPABILITY_ID
    unset CAPABILITY_NAME
    unset CAPABILITY_DESCRIPTION
    unset CAPABILITY_DEPENDENCIES

    unset -f capability_install 2>/dev/null || true
    unset -f capability_verify 2>/dev/null || true

    source "$capability_dir/capability.sh" || {
        forge_error "Failed to load capability.sh"
        return "$FORGE_CAPABILITY_NOT_FOUND"
    }

    forge_validate_capability_interface "$capability" || return $?
}


##############################
### Execute the capability ###
##############################

forge_execute_capability() {

    local capability="$1"

    (
        forge_load_capability "$capability" || exit $?

        forge_step "$CAPABILITY_NAME..."
        echo

        forge_check \
            "Installing..." \
            "Tools installed" \
            "Installation failed" \
            capability_install ||
            exit "$FORGE_INSTALL_FAILED"

        forge_check \
            "Verifying..." \
            "Tools verified" \
            "Verification failed" \
            capability_verify ||
            exit "$FORGE_VERIFY_FAILED"
        
        echo
        forge_success "$CAPABILITY_NAME Ready"
    )

}
