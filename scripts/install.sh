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

failed_packages=()

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
    # yazi and lazygit aren't in default Fedora repos; pull from COPRs.
    # Idempotent: copr enable is a no-op if already enabled.
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

if [ "${#failed_packages[@]}" -gt 0 ]; then
    echo
    echo "Failed: ${failed_packages[*]}"
fi

cat <<'EOF'

Next steps:
  cd ~/code/dotfiles
  stow -t ~ zsh tmux nvim ghostty fish    # symlink configs
  chsh -s "$(command -v zsh)"             # set zsh as login shell
  gh auth login                           # GitHub CLI auth (optional)
EOF
