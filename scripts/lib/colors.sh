#!/usr/bin/env bash

# ============================================================
# Colors & formatting
# ============================================================

RESET=''
RED=''
GREEN=''
YELLOW=''
BLUE=''
CYAN=''
BOLD=''

use_color() {
    case "$COLOR_MODE" in
        always)
            return 0
            ;;

        never)
            return 1
            ;;

        auto)
            [[ -t 1 ]]
            ;;

        *)
            printf 'Invalid COLOR_MODE: %s\n' "$COLOR_MODE" >&2
            return 1
            ;;
    esac
}

if use_color; then
    RESET=$'\033[0m'
    RED=$'\033[0;31m'
    GREEN=$'\033[0;32m'
    YELLOW=$'\033[1;33m'
    BLUE=$'\033[0;34m'
    CYAN=$'\033[0;36m'
    BOLD=$'\033[1m'
fi