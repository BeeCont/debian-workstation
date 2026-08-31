#!/usr/bin/env bash

# ============================================================
# Package metadata parser
# ============================================================

GROUP_NAME=''
GROUP_DESCRIPTION=''
GROUP_RISK=''

declare -a PACKAGE_METADATA_NAMES=()
declare -a PACKAGES=()
declare -A PACKAGE_WHY=()


reset_package_group() {
    GROUP_NAME=''
    GROUP_DESCRIPTION=''
    GROUP_RISK=''

    PACKAGE_METADATA_NAMES=()
    PACKAGES=()
    PACKAGE_WHY=()
}


load_package_group() {
    local file="$1"

    reset_package_group

    local line=''
    local current_package=''
    local packages_started=0

    while IFS= read -r line || [[ -n "$line" ]]; do

        [[ -z "$line" ]] && continue

        if [[ "$line" =~ ^[[:space:]]*#[[:space:]]*@name:[[:space:]]*(.*)$ ]]; then
            GROUP_NAME="${BASH_REMATCH[1]}"
            continue
        fi

        if [[ "$line" =~ ^[[:space:]]*#[[:space:]]*@description:[[:space:]]*(.*)$ ]]; then
            GROUP_DESCRIPTION="${BASH_REMATCH[1]}"
            continue
        fi

        if [[ "$line" =~ ^[[:space:]]*#[[:space:]]*@risk:[[:space:]]*(.*)$ ]]; then
            GROUP_RISK="${BASH_REMATCH[1]}"
            continue
        fi

        if [[ "$line" =~ ^[[:space:]]*#[[:space:]]*@package:[[:space:]]*(.*)$ ]]; then
            current_package="${BASH_REMATCH[1]}"
            PACKAGE_METADATA_NAMES+=("$current_package")
            continue
        fi

        if [[ "$line" =~ ^[[:space:]]*#[[:space:]]*@why:[[:space:]]*(.*)$ ]]; then
            if [[ -z "$current_package" ]]; then
                printf 'Error: @why without @package in %s\n' "$file" >&2
                return 1
            fi

            PACKAGE_WHY["$current_package"]="${BASH_REMATCH[1]}"
            continue
        fi

        if [[ "$line" =~ ^[[:space:]]*#[[:space:]]*@packages[[:space:]]*$ ]]; then
            packages_started=1
            continue
        fi

        if (( packages_started )); then
            [[ "$line" =~ ^[[:space:]]*# ]] && continue

            line="${line#"${line%%[![:space:]]*}"}"
            line="${line%"${line##*[![:space:]]}"}"

            [[ -z "$line" ]] && continue

            PACKAGES+=("$line")
        fi

    done < "$file"
}