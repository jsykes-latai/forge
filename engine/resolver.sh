#!/usr/bin/env bash

################################
### Capability dependencies  ###
################################

declare -A FORGE_CAPABILITY_RESOLUTION_STATE=()
declare -a FORGE_RESOLVED_CAPABILITIES=()
declare -a FORGE_DEPENDENCY_STACK=()

forge_reset_capability_resolver() {
    FORGE_CAPABILITY_RESOLUTION_STATE=()
    FORGE_RESOLVED_CAPABILITIES=()
    FORGE_DEPENDENCY_STACK=()
}

forge_resolve_capabilities() {
    forge_reset_capability_resolver

    local capability

    # echo "resolver inputs: $*"

    for capability in "$@"; do
        # echo "resolving root: $capability"
        forge_resolve_capability "$capability" || return $?
    done

    # declare -p FORGE_RESOLVED_CAPABILITIES

    return "$FORGE_SUCCESS"
}

forge_resolve_capability() {
    local capability="$1"
    local state="${FORGE_CAPABILITY_RESOLUTION_STATE[$capability]:-unvisited}"

    # echo "resolve_capability: $capability state=$state"

    case "$state" in
        complete)
            # echo "already complete: $capability"
            return "$FORGE_SUCCESS"
            ;;

        visiting)
            forge_report_dependency_cycle "$capability"
            return "$FORGE_DEPENDENCY_CYCLE"
            ;;
    esac

    FORGE_CAPABILITY_RESOLUTION_STATE["$capability"]="visiting"
    FORGE_DEPENDENCY_STACK+=("$capability")

    forge_load_capability "$capability" || {
        local status=$?
        forge_pop_dependency_stack
        return "$status"
    }

    local -a dependencies=("${CAPABILITY_DEPENDENCIES[@]}")
    local dependency

    # echo "$capability dependencies: ${dependencies[*]:-(none)}"

    for dependency in "${dependencies[@]}"; do
        if [[ ! -d "$FORGE_ROOT/capabilities/$dependency" ]]; then
            forge_error \
                "Capability '$capability' requires missing dependency: $dependency"

            forge_pop_dependency_stack
            return "$FORGE_DEPENDENCY_NOT_FOUND"
        fi

        forge_resolve_capability "$dependency" || {
            local status=$?
            forge_pop_dependency_stack
            return "$status"
        }
    done

    forge_pop_dependency_stack

    FORGE_CAPABILITY_RESOLUTION_STATE["$capability"]="complete"
    FORGE_RESOLVED_CAPABILITIES+=("$capability")

    # echo "appended: $capability"
    # declare -p FORGE_RESOLVED_CAPABILITIES

    return "$FORGE_SUCCESS"
}

forge_pop_dependency_stack() {
    local stack_length="${#FORGE_DEPENDENCY_STACK[@]}"

    if (( stack_length > 0 )); then
        unset "FORGE_DEPENDENCY_STACK[$((stack_length - 1))]"
    fi
}

forge_report_dependency_cycle() {
    local repeated_capability="$1"
    local -a cycle=()
    local include=false
    local capability

    for capability in "${FORGE_DEPENDENCY_STACK[@]}"; do
        if [[ "$capability" == "$repeated_capability" ]]; then
            include=true
        fi

        if [[ "$include" == true ]]; then
            cycle+=("$capability")
        fi
    done

    cycle+=("$repeated_capability")

    local cycle_path=""
    local separator=""

    for capability in "${cycle[@]}"; do
        cycle_path+="${separator}${capability}"
        separator=" -> "
    done

    forge_error "Dependency cycle detected: $cycle_path"
}
