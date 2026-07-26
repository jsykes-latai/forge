#!/usr/bin/env bash
# That's it.
# No installation logic.
# No package management.
# No copying files.
# Bootstrap simply starts the engine.

set -euo pipefail

source engine/logger.sh
source engine/profile.sh
source engine/module.sh
source engine/runner.sh

main "$@"
