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

    [[ -d "$capability_dir" ]] || return 1

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
            return 1
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
            return 1
        fi

    done


    for variable in "${FORGE_REQUIRED_CAPABILITY_VARIABLES[@]}"; do

        if [[ -z "${!variable:-}" ]]; then
            forge_error "Missing required variable: $variable"
            return 1
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
        return 1
    }

    forge_validate_capability "$capability_dir" || return 1

    source "$capability_dir/capability.sh" || {
        forge_error "Failed to load capability.sh"
        return 1
    }

    source "$capability_dir/install.sh" || {
        forge_error "Failed to load install.sh"
        return 1
    }

    source "$capability_dir/verify.sh" || {
        forge_error "Failed to load verify.sh"
        return 1
    }

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
