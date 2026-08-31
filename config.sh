#!/usr/bin/env bash

# ============================================================
# Global configuration and defaults
# ============================================================

# Repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Paths
PACKAGES_DIR="${REPO_ROOT}/packages"
SCRIPTS_DIR="${REPO_ROOT}/scripts"
LIB_DIR="${SCRIPTS_DIR}/lib"

# Output defaults
COLOR_MODE="${COLOR_MODE:-auto}"
SYMBOL_MODE="${SYMBOL_MODE:-auto}"

# APT
DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND