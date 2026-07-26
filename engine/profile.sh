load_profile() {

    PROFILE_NAME="$1"

    PROFILE_FILE="$FORGE_ROOT/profiles/$PROFILE_NAME.yaml"

    if [[ ! -f "$PROFILE_FILE" ]]; then
        forge_error "Profile not found: $PROFILE_NAME"
        return "$FORGE_PROFILE_NOT_FOUND"
    fi


    CAPABILITIES=()


    while read -r line; do

        if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*(.*)$ ]]; then
            CAPABILITIES+=("${BASH_REMATCH[1]}")
        fi

    done < "$PROFILE_FILE"

}
