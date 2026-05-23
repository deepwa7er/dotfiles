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

install_fedora() {
    # yazi and lazygit aren't in default Fedora repos; pull from COPRs
    sudo dnf copr enable -y atim/lazygit
    sudo dnf copr enable -y lihaohong/yazi
    sudo dnf install -y "${fedora_packages[@]}"
}

install_macos() {
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Install from https://brew.sh first." >&2
        exit 1
    fi
    brew install "${brew_packages[@]}"
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

cat <<'EOF'

Next steps:
  cd ~/code/dotfiles
  stow -t ~ zsh tmux nvim ghostty fish    # symlink configs
  chsh -s "$(command -v zsh)"             # set zsh as login shell
  gh auth login                           # GitHub CLI auth (optional)
EOF
