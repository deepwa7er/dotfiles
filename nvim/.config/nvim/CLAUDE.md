# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal Neovim configuration based on kickstart.nvim, managed as part of a larger dotfiles repo (`~/dotfiles/`) using GNU Stow. The nvim stow package symlinks `nvim/.config/nvim/` to `~/.config/nvim/`.

## Architecture

Everything flows from `init.lua` — a single-file config that sets options, keymaps, autocommands, and configures all plugins via lazy.nvim in one `require('lazy').setup({...})` call.

### Key structural decisions:
- **Leader key**: Space
- **Plugin manager**: lazy.nvim (`:Lazy` to manage, `:Lazy update` to update)
- **LSP**: nvim-lspconfig + Mason (`:Mason` to manage installed servers/tools). Servers are declared in the `servers` table inside the lspconfig config function. Mason auto-installs them.
- **Completion**: blink.cmp with LuaSnip for snippets
- **Formatting**: conform.nvim — formats on save (with `lsp_format = 'fallback'`), disabled for C/C++. Lua uses `stylua`.
- **Colorscheme**: Custom monochrome theme via colorbuddy.nvim, defined in `lua/colors/monochrome.lua`. Transparent background (guibg=none).
- **Fuzzy finder**: Telescope (fzf-native + ui-select extensions)
- **Statusline**: mini.statusline
- **Treesitter**: auto-install enabled

### Extension points (currently unused):
- `lua/custom/plugins/*.lua` — for adding plugins without touching init.lua (the `{ import = 'custom.plugins' }` line in init.lua is currently commented out)
- `lua/kickstart/plugins/` — bundled optional plugins (debug, indent_line, lint, autopairs, neo-tree, gitsigns keymaps) — all currently commented out in the require lines near the bottom of init.lua

### File-type specific settings:
- HTML, CSS, JS, TS, JSX, TSX: 2-space indentation (autocommand in init.lua)

## Checking Health

```
:checkhealth kickstart
```
