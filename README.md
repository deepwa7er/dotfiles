# dotfiles

Personal config for Fedora Linux and macOS.

## Setup

```
git clone git@github.com:deepwa7er/dotfiles.git ~/code/dotfiles
~/code/dotfiles/scripts/install.sh
```

The install script is idempotent and self-running. It will:

- Install packages with `dnf` (Fedora) or `brew` (macOS).
- Symlink configs into `$HOME` with `stow`.
- Set zsh as the login shell.
- Check `gh auth status` and hint if not yet authenticated.

Already-installed packages and already-linked configs print `skip` instead of
erroring. Failed installs don't abort the rest of the run; the script lists
them at the end.

## Packages

Each top-level directory (except `scripts/`) is a stow package. Stow target
is `$HOME` — run `stow -t ~ <package>` from the repo root, or let the install
script do it.

| Package    | Contents                                                          |
| ---------- | ----------------------------------------------------------------- |
| `fish/`    | Fish shell config (used on macOS)                                 |
| `ghostty/` | Ghostty terminal config                                           |
| `git/`     | `.gitconfig` — user, editor, and delta as the pager               |
| `nvim/`    | Neovim config (kickstart-based) + `.luarc.json` for lua_ls        |
| `tmux/`    | tmux config; `.tmux.conf.mac` sourced via `if-shell` on Darwin    |
| `zsh/`     | Zsh config (used on Linux)                                        |

## Manual step

`gh auth login` — interactive OAuth doesn't hand off cleanly from a script,
so the script just hints. Run it once per machine.
