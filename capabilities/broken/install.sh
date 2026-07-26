#!/usr/bin/env bash

CAPABILITY_NAME="Broken capability"

capability_verify() {
    return 1
}

capability_install() {
    return 0
}

capability_confirm() {
    return 0
}
