# Reads a profile. Returns a list of modules. Nothing else.

#!/usr/bin/env bash

PROFILE_DIR="$(dirname "${BASH_SOURCE[0]}")/../profiles"

load_profile() {

    PROFILE="$1"

    PROFILE_FILE="$PROFILE_DIR/$PROFILE.conf"

    if [[ ! -f "$PROFILE_FILE" ]]; then
        log_error "Profile '$PROFILE' not found"
        exit 1
    fi

    source "$PROFILE_FILE"
}
