capability_install() {

    if command -v zsh >/dev/null 2>&1; then
        return 0
    fi

    sudo pacman -S --needed --noconfirm zsh

}
