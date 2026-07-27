CAPABILITY_ID="shell"
CAPABILITY_NAME="Shell environment"
CAPABILITY_DESCRIPTION="Terminal and shell tooling"

SHELL_CAPABILITY_DIR="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
    pwd
)"

source "$SHELL_CAPABILITY_DIR/install.sh"
source "$SHELL_CAPABILITY_DIR/verify.sh"

capability_install() {
    shell_install
}

capability_verify() {
    shell_verify
}
