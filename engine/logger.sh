# Only output. Never installs anything. Responsible for things like: INFO, SUCCESS, WARNING, ERROR, ETC.

#!/usr/bin/env bash

log_info() {
    echo "  [INFO] $1"
}

log_success() {
    echo "  [ OK ] $1"
}

log_error() {
    echo "  [ERR ] $1"
}
