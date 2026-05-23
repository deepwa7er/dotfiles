#!/usr/bin/env bash
set -euo pipefail

fedora_packages=(
    zsh stow
    neovim
    golang
    fzf zoxide yazi
    eza bat ripgrep fd-find
    lazygit git-delta gh
    btop jq httpie
)

brew_packages=(
    zsh stow
    neovim
    go
    fzf zoxide yazi
    eza bat ripgrep fd
    lazygit git-delta gh
    btop jq httpie
)

stow_packages=(zsh tmux nvim ghostty fish git)

failed_packages=()

repo_dir() {
    cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
}

install_one_fedora() {
    local pkg="$1"
    local log
    if rpm -q "$pkg" >/dev/null 2>&1; then
        printf '  skip  %s (already installed)\n' "$pkg"
        return 0
    fi
    if log=$(sudo dnf install -y "$pkg" 2>&1); then
        printf '  ok    %s\n' "$pkg"
    else
        printf '  FAIL  %s\n' "$pkg"
        printf '%s\n' "$log" | sed 's/^/        | /'
        failed_packages+=("$pkg")
    fi
}

install_one_brew() {
    local pkg="$1"
    local log
    if brew list --formula "$pkg" >/dev/null 2>&1; then
        printf '  skip  %s (already installed)\n' "$pkg"
        return 0
    fi
    if log=$(brew install "$pkg" 2>&1); then
        printf '  ok    %s\n' "$pkg"
    else
        printf '  FAIL  %s\n' "$pkg"
        printf '%s\n' "$log" | sed 's/^/        | /'
        failed_packages+=("$pkg")
    fi
}

install_fedora() {
    sudo dnf copr enable -y atim/lazygit \
        || echo "  warn  could not enable atim/lazygit COPR"
    sudo dnf copr enable -y lihaohong/yazi \
        || echo "  warn  could not enable lihaohong/yazi COPR"
    echo "Installing packages..."
    for pkg in "${fedora_packages[@]}"; do
        install_one_fedora "$pkg"
    done
}

install_macos() {
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Install from https://brew.sh first." >&2
        exit 1
    fi
    echo "Installing packages..."
    for pkg in "${brew_packages[@]}"; do
        install_one_brew "$pkg"
    done
}

stow_one() {
    local pkg="$1"
    local dir="$2"
    local log
    if [ ! -d "$dir/$pkg" ]; then
        printf '  skip  %s (no such package)\n' "$pkg"
        return 0
    fi
    if log=$(stow -d "$dir" -t "$HOME" "$pkg" 2>&1); then
        printf '  ok    %s\n' "$pkg"
    else
        printf '  FAIL  %s\n' "$pkg"
        printf '%s\n' "$log" | sed 's/^/        | /'
    fi
}

stow_configs() {
    if ! command -v stow >/dev/null 2>&1; then
        echo "  warn  stow not installed, skipping config link step"
        return 0
    fi
    local dir
    dir="$(repo_dir)"
    echo "Linking configs..."
    for pkg in "${stow_packages[@]}"; do
        stow_one "$pkg" "$dir"
    done
}

current_login_shell() {
    if [ "$(uname -s)" = "Darwin" ]; then
        dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}'
    else
        getent passwd "$USER" | cut -d: -f7
    fi
}

set_login_shell_to_zsh() {
    local zsh_path current
    zsh_path=$(command -v zsh || true)
    if [ -z "$zsh_path" ]; then
        printf '  skip  chsh (zsh not installed)\n'
        return 0
    fi
    current=$(current_login_shell)
    if [ "$current" = "$zsh_path" ]; then
        printf '  skip  chsh (login shell already zsh)\n'
        return 0
    fi
    echo "Setting login shell to $zsh_path (you'll be prompted for your password)..."
    if chsh -s "$zsh_path"; then
        printf '  ok    chsh to zsh\n'
    else
        printf '  FAIL  chsh\n'
    fi
}

check_gh_auth() {
    if ! command -v gh >/dev/null 2>&1; then
        return 0
    fi
    if gh auth status >/dev/null 2>&1; then
        printf '  skip  gh auth (already authenticated)\n'
    else
        echo
        echo "GitHub CLI is not authenticated. To finish setup, run:"
        echo "  gh auth login"
    fi
}

case "$(uname -s)" in
    Linux*)
        if ! command -v dnf >/dev/null 2>&1; then
            echo "Linux detected but no dnf. Only Fedora is supported." >&2
            exit 1
        fi
        install_fedora
        ;;
    Darwin*)
        install_macos
        ;;
    *)
        echo "Unsupported OS: $(uname -s)" >&2
        exit 1
        ;;
esac

echo
stow_configs

echo
set_login_shell_to_zsh

echo
check_gh_auth

if [ "${#failed_packages[@]}" -gt 0 ]; then
    echo
    echo "Failed package installs: ${failed_packages[*]}"
fi
