#!/usr/bin/env bash

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO="creusvictor/keepassxc-fzf"
SCRIPT_NAME="keepassxc-fzf"
RAW_URL="https://raw.githubusercontent.com/${REPO}/main/${SCRIPT_NAME}"

print_error()   { echo -e "${RED}Error: $1${NC}" >&2; }
print_success() { echo -e "${GREEN}$1${NC}"; }
print_info()    { echo -e "${BLUE}$1${NC}"; }
print_warning() { echo -e "${YELLOW}Warning: $1${NC}"; }

# Determine install directory
detect_install_dir() {
    if [ "${PREFIX:-}" != "" ]; then
        echo "${PREFIX}/bin"
    elif [ "$(id -u)" -eq 0 ]; then
        echo "/usr/local/bin"
    elif [[ ":$PATH:" == *":/usr/local/bin:"* ]] && [ -w "/usr/local/bin" ]; then
        echo "/usr/local/bin"
    else
        echo "${HOME}/.local/bin"
    fi
}

# Check required dependencies
check_dependencies() {
    local missing=()

    for cmd in keepassxc-cli fzf bash; do
        if ! command -v "$cmd" &>/dev/null; then
            missing+=("$cmd")
        fi
    done

    if [ ${#missing[@]} -ne 0 ]; then
        print_warning "Missing dependencies: ${missing[*]}"
        print_warning "Install them before using ${SCRIPT_NAME}."
    fi
}

# Download and install
install() {
    local install_dir
    install_dir=$(detect_install_dir)
    local dest="${install_dir}/${SCRIPT_NAME}"

    print_info "Installing ${SCRIPT_NAME} to ${install_dir}..."

    # Create install dir if needed
    if [ ! -d "$install_dir" ]; then
        mkdir -p "$install_dir"
    fi

    # Check write permission
    if [ ! -w "$install_dir" ]; then
        print_error "No write permission to ${install_dir}. Try running with sudo or set PREFIX=~/.local."
        exit 1
    fi

    # Download
    if command -v curl &>/dev/null; then
        curl -fsSL "$RAW_URL" -o "$dest"
    elif command -v wget &>/dev/null; then
        wget -qO "$dest" "$RAW_URL"
    else
        print_error "Neither curl nor wget found. Please install one of them."
        exit 1
    fi

    chmod 755 "$dest"

    print_success "${SCRIPT_NAME} installed successfully to ${dest}"

    # Warn if install dir is not in PATH
    if [[ ":$PATH:" != *":${install_dir}:"* ]]; then
        print_warning "${install_dir} is not in your PATH."
        echo "  Add this to your shell config (~/.bashrc, ~/.zshrc, etc.):"
        echo "    export PATH=\"${install_dir}:\$PATH\""
    fi

    check_dependencies

    echo
    print_info "Run '${SCRIPT_NAME} --help' to get started."
}

install
