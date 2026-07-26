#!/usr/bin/env bash

verify() {

    echo "      Verifying shell capability..."

    if command -v zsh >/dev/null 2>&1; then
        echo "      ✓ zsh available"
        return 0
    else
        echo "      ✗ zsh missing"
        return 1
    fi

}
