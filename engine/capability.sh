execute_capability() {

    local capability="$1"

    load_capability "$capability"

    forge_step "$CAPABILITY_NAME"

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
