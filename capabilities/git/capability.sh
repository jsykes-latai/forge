CAPABILITY_ID="git"
CAPABILITY_NAME="Git"
CAPABILITY_DESCRIPTION="Version control system installed and ready for configuration"

GIT_CAPABILITY_DIR="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
    pwd
)"

source "$GIT_CAPABILITY_DIR/install.sh"
source "$GIT_CAPABILITY_DIR/verify.sh"

capability_install() {
    git_install
}

capability_verify() {
    git_verify
}
