# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Minimal Neovim configuration written in Lua. Uses **native Neovim package management** (`:h packages`) — no third-party plugin manager. The sole installed plugin is `nvim-treesitter`.

## Structure

- `init.lua` — single entry point; all personal config lives here
- `pack/plugins/start/` — auto-loaded plugins (native packaging)
- `pack/plugins/start/nvim-treesitter/` — the only installed plugin

## Key Design Decisions

- **No plugin manager**: plugins are git-cloned into `pack/plugins/start/` and load automatically
- **Single-file config**: all options, keymaps, and autocmds are in `init.lua`
- **Treesitter-first**: syntax highlighting is enabled globally via autocmd; function navigation uses inline Treesitter queries rather than external plugins
- **Indentation**: 4 spaces by default; 2 spaces for `lua`, `html`, `js`, `jsx`, `ts`, `tsx`

## Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `<S-l>` / `<S-h>` | Normal | Next / previous buffer |
| `]f` / `[f` | Normal | Jump to next / previous function (Treesitter) |
| `<space><space>x` | Normal | Source current file |
| `<space>x` | Normal/Visual | Execute current line / selection as Lua |

Function navigation supports: Rust, Python, C, Lua, JavaScript, TypeScript.

## Working with nvim-treesitter

The plugin has its own Makefile for development:

```sh
cd pack/plugins/start/nvim-treesitter

make lua      # Format and lint Lua code (StyLua + lua-language-server)
make query    # Format, lint, and check Tree-sitter query files
make tests    # Run test suite (plentest.nvim, headless Neovim)
make docs     # Regenerate docs from README
make all      # Run all checks
```

The Makefile downloads its own toolchain (Neovim nightly, luals, StyLua, ts_query_ls, plentest.nvim) into a local `deps/` directory — no system-level installs needed.

## Adding Plugins

Clone the plugin repo into `pack/plugins/start/<plugin-name>/`. It will load automatically on next Neovim startup. No registration required.
