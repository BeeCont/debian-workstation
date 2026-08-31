#!/usr/bin/env bash

# ============================================================
# CLI output helpers
# ============================================================

# ------------------------------------------------------------
# Symbols
# ------------------------------------------------------------

SYMBOL_SUCCESS='[OK]'
SYMBOL_WARNING='[WARN]'
SYMBOL_ERROR='[ERROR]'
SYMBOL_INFO='[INFO]'
SYMBOL_STEP='==>'

init_symbols() {
    case "$SYMBOL_MODE" in
        always)
            SYMBOL_SUCCESS='✓'
            SYMBOL_WARNING='!'
            SYMBOL_ERROR='✗'
            SYMBOL_INFO='→'
            SYMBOL_STEP='==>'
            ;;

        never)
            SYMBOL_SUCCESS='[OK]'
            SYMBOL_WARNING='[WARN]'
            SYMBOL_ERROR='[ERROR]'
            SYMBOL_INFO='[INFO]'
            SYMBOL_STEP='==>'
            ;;

        auto)
            if [[ -t 1 ]]; then
                SYMBOL_SUCCESS='✓'
                SYMBOL_WARNING='!'
                SYMBOL_ERROR='✗'
                SYMBOL_INFO='→'
                SYMBOL_STEP='==>'
            else
                SYMBOL_SUCCESS='[OK]'
                SYMBOL_WARNING='[WARN]'
                SYMBOL_ERROR='[ERROR]'
                SYMBOL_INFO='[INFO]'
                SYMBOL_STEP='==>'
            fi
            ;;

        *)
            printf 'Invalid SYMBOL_MODE: %s\n' "$SYMBOL_MODE" >&2
            return 1
            ;;
    esac
}

init_symbols


# ------------------------------------------------------------
# Header
# ------------------------------------------------------------

print_header() {
    printf '\n%s%s%s\n' \
        "$BOLD" "$BLUE" "$1"

    printf '%s────────────────────────────────────────────────────────%s\n' \
        "$BLUE" "$RESET"
}


# ------------------------------------------------------------
# Sections
# ------------------------------------------------------------

print_section() {
    printf '\n%s%s%s\n' \
        "$BOLD" "$1" "$RESET"
}


# ------------------------------------------------------------
# Status messages
# ------------------------------------------------------------

print_success() {
    printf '%s%s%s %s\n' \
        "$GREEN" "$SYMBOL_SUCCESS" "$RESET" "$1"
}

print_warning() {
    printf '%s%s%s %s\n' \
        "$YELLOW" "$SYMBOL_WARNING" "$RESET" "$1"
}

print_error() {
    printf '%s%s%s %s\n' \
        "$RED" "$SYMBOL_ERROR" "$RESET" "$1" >&2
}

print_info() {
    printf '%s%s%s %s\n' \
        "$CYAN" "$SYMBOL_INFO" "$RESET" "$1"
}

print_step() {
    printf '\n%s%s%s %s%s%s\n' \
        "$BOLD" "$CYAN" "$SYMBOL_STEP" "$RESET" "$1" "$RESET"
}


# ------------------------------------------------------------
# Fatal error
# ------------------------------------------------------------

die() {
    print_error "$1"
    exit 1
}