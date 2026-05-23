# Editor
if command -v vim >/dev/null 2>&1; then
    alias vi="vim"
    EDITOR="vim"
fi
if command -v nvim >/dev/null 2>&1; then
    alias vi="nvim"
    EDITOR="nvim"
fi

# Prompt
PROMPT="%F{cyan}%n %f%~ %F{magenta}󰬯%f "

# Vi mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH=$HOME/.dotfiles/scripts:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

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

alias ls='ls --color=auto'
alias python='python3'
