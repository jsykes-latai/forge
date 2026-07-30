CAPABILITY_ID="github"
CAPABILITY_NAME="GitHub"
CAPABILITY_DESCRIPTION="Github CLI installation and verification. Configuration left to user."
CAPABILITY_DEPENDENCIES=("git")

GITHUB_CAPABILITY_DIR="$(
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
    pwd
)"

source "$GITHUB_CAPABILITY_DIR/install.sh"
source "$GITHUB_CAPABILITY_DIR/verify.sh"

capability_install() {
    github_install
}

capability_verify() {
    github_verify
}
