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
    CAPABILITY_NAME
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

    for function in "${FORGE_REQUIRED_CAPABILITY_FUNCTIONS[@]}"; do

        if ! declare -F "$function" >/dev/null; then
            forge_error "Missing required function: $function"
            return "$FORGE_CAPABILITY_INVALID"
        fi

    done


    for variable in "${FORGE_REQUIRED_CAPABILITY_VARIABLES[@]}"; do

        if [[ -z "${!variable:-}" ]]; then
            forge_error "Missing required variable: $variable"
            return "$FORGE_CAPABILITY_INVALID"
        fi

    done

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

    source "$capability_dir/capability.sh" || {
        forge_error "Failed to load capability.sh"
        return "$FORGE_CAPABILITY_NOT_FOUND"
    }

    source "$capability_dir/install.sh" || {
        forge_error "Failed to load install.sh"
        return "$FORGE_CAPABILITY_NOT_FOUND"
    }

    source "$capability_dir/verify.sh" || {
        forge_error "Failed to load verify.sh"
        return "$FORGE_CAPABILITY_NOT_FOUND"
    }

    forge_validate_capability_interface || return $?
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
