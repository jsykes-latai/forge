# Coordinates everything. Read Profile -> For Each module (Execute Module) -> Done

#!/usr/bin/env bash

ENGINE_DIR="$(dirname "${BASH_SOURCE[0]}")"
FORGE_ROOT="$(dirname "$ENGINE_DIR")"

source "$ENGINE_DIR/ui.sh"
source "$ENGINE_DIR/logger.sh"
source "$ENGINE_DIR/profile.sh"
source "$ENGINE_DIR/capability.sh"


build_profile() {

    PROFILE="$1"

    forge_header "$PROFILE"

    forge_phase "Loading profile"

    load_profile "$PROFILE"

    forge_success "Profile loaded: $PROFILE"

    forge_phase "Capabilities detected"

    for capability in "${CAPABILITIES[@]}"; do
        forge_step "$capability"
    done
    
    forge_phase "Building capabilities:"

    for capability in "${CAPABILITIES[@]}"; do

        execute_capability "$capability" || return 1
        
    done

    echo
    forge_complete

}
