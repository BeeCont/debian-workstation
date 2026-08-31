#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# debian-workstation - bootstrap.sh
# Minimal base required to run setup.sh
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=config.sh
. "${SCRIPT_DIR}/config.sh"

# shellcheck source=scripts/lib/colors.sh
. "${LIB_DIR}/colors.sh"

# shellcheck source=scripts/lib/output.sh
. "${LIB_DIR}/output.sh"

# shellcheck source=scripts/lib/extract_packages.sh
. "${LIB_DIR}/extract_packages.sh"



check_root() {
    if [[ $EUID -ne 0 ]]; then
        die "bootstrap.sh must be run as root"
    fi
}


main() {
    check_root

    local core_file="${PACKAGES_DIR}/core.txt"

    load_package_group "$core_file"

    print_header "debian-workstation"

    print_section "$GROUP_NAME"
    print_info "$GROUP_DESCRIPTION"

    printf '\nRisk: %s\n' "$GROUP_RISK"

    print_section "Packages"

    local package

    for package in "${PACKAGES[@]}"; do
        print_info "$package"

        if [[ -n "${PACKAGE_WHY[$package]:-}" ]]; then
            printf '    %s\n' "${PACKAGE_WHY[$package]}"
        fi
    done

    print_step "Checking installed packages"

    local missing_packages=()

    for package in "${PACKAGES[@]}"; do
        if ! dpkg -s "$package" &>/dev/null; then
            missing_packages+=("$package")
        fi
    done

    if (( ${#missing_packages[@]} > 0 )); then
        print_info "Installing ${#missing_packages[@]} missing package(s)"

        apt-get update -y

        apt-get install \
            -y \
            --no-install-recommends \
            "${missing_packages[@]}"

        print_success "Packages installed"
    else
        print_success "All packages are already installed"
    fi

    print_success "Bootstrap complete"
}


main "$@"