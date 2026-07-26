# Zsh config for both Fedora Linux and macOS.
# Shared sections first; OS-specific paths live in the uname blocks.

# PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH=$HOME/.dotfiles/scripts:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.kimi-code/bin:$PATH

if [[ $(uname) == Darwin ]]; then
    # Homebrew
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    # Laravel Herd + composer global bin
    export PATH=$HOME/.config/herd-lite/bin:$PATH
    export PATH=$HOME/.config/composer/vendor/bin:$PATH
    # LM Studio CLI (lms)
    export PATH=$PATH:$HOME/.lmstudio/bin
fi

# Rust is managed by rustup, never by a system package manager. Only rustup's
# shims honor a repo's rust-toolchain.toml pin and can install cross-compilation
# targets (the fleet builds x86_64-unknown-linux-musl for the VPS).
#
# This MUST stay after the Homebrew block: Homebrew prepends itself to PATH, so
# with this line earlier in the file a brew-installed rust would shadow rustup —
# builds then silently ignore the toolchain pin and cannot cross-compile.
export PATH=$HOME/.cargo/bin:$PATH

# Runtime version manager (provides ruby, node, etc.)
if [ -x "$HOME/.local/bin/mise" ]; then
    eval "$($HOME/.local/bin/mise activate zsh)"
fi

# Editor
if command -v vim >/dev/null 2>&1; then
    alias vi="vim"
    EDITOR="vim"
fi
if command -v nvim >/dev/null 2>&1; then
    alias vi="nvim"
    EDITOR="nvim"
fi

# Let `tugboat fleet …` find the fleet manifest from any directory.
if [ -f "$HOME/code/fleet/fleet.toml" ]; then
    export TUGBOAT_FLEET=$HOME/code/fleet/fleet.toml
fi

# eza theme (looks in ~/Library/Application Support on macOS unless told
# otherwise; on Linux this matches the default, so exporting is harmless)
export EZA_CONFIG_DIR=$HOME/.config/eza

# Vi mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# Prompt: USGC-RETICLE — vi-mode tag, white user, phosphor-green cwd
# (default foreground), dim-green git branch, red status + accent glyph.
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats ' %F{#00753d}(%b)%f'
zstyle ':vcs_info:*' enable git
precmd() { vcs_info }

MODE_INDICATOR='%F{#00753d}[I]%f'
function zle-keymap-select zle-line-init {
    case $KEYMAP in
        vicmd) MODE_INDICATOR='%B%F{red}[N]%f%b' ;;
        *)     MODE_INDICATOR='%F{#00753d}[I]%f' ;;
    esac
    zle reset-prompt
}
zle -N zle-keymap-select
zle -N zle-line-init

PROMPT='${MODE_INDICATOR} %F{white}%n %f%~${vcs_info_msg_0_} %(?..%F{red}[%?]%f )%F{red}󰬯%f '

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Completion
autoload -Uz compinit && compinit

# Fuzzy finder (key bindings + completion)
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

# Directory jumper (provides `z` and `zi`)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Aliases
if command -v eza >/dev/null 2>&1; then
    alias ls='eza'
else
    alias ls='ls --color=auto'
fi
if command -v bat >/dev/null 2>&1; then
    alias cat='bat'
fi
alias python='python3'

# yazi: `y` changes the shell's directory to where yazi exited
function y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
