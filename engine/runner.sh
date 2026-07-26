# Coordinates everything. Read Profile -> For Each module (Execute Module) -> Done

main() {

    log_info "Starting Forge..."

    load_profile

    run_modules

    log_success "Forge complete."

}
