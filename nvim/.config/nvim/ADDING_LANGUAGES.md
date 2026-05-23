# Adding a New Language

## How language support works

**Treesitter** is enabled globally via a `FileType` autocmd — it calls `vim.treesitter.start` for every buffer. The only per-language addition needed is a query string in the `queries` table inside `jump_to_function`, which drives `]f`/`[f` function navigation.

**LSP** uses `nvim-lspconfig` (loaded via `vim.pack.add`). You configure a server with `vim.lsp.config(...)` and activate it with `vim.lsp.enable(...)`. Completion, diagnostics, and inlay hints are wired up globally and work automatically once a server is enabled.

---

## Steps

### 1. Install the Treesitter parser

Inside Neovim:
```
:TSInstall <language>
```

**Verify the install worked:**

- `:checkhealth nvim-treesitter` — runs a full health check; failures here (missing compiler, bad parser) are reported with actionable messages.
- Open a file of that type and run `:Inspect` on a token — if Treesitter is active you'll see `@`-prefixed highlight groups (e.g. `@keyword`, `@function`) in the output. Plain `hl-` groups with no `@` prefix means Treesitter is not running for that buffer.
- As a quick Lua check: `:lua print(vim.treesitter.get_parser(0, '<language>'))` should print a parser object, not `nil` or an error.

If `TSInstall` fails (network error, missing C compiler), the parser directory may be left in a broken state. Run `:TSUninstall <language>` before retrying to clear it out.

### 2. Add a function-navigation query

Find the correct node name for function definitions in the language's Treesitter grammar. Use `:InspectTree` while in a file of that type to browse the syntax tree.

Add an entry to the `queries` table in `jump_to_function`:
```lua
go = '(function_declaration) @fn',
```
The key must match what `vim.bo.filetype` reports for that language (check with `:set ft?`).

### 3. Install the language server

This is a system-level step outside Neovim. Look up the server name on the
[nvim-lspconfig server list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)
and install the binary via your package manager or language toolchain.

**Homebrew vs. language toolchain:**

Use the language's own toolchain when the server is tightly coupled to the language version — e.g. `go install` for `gopls`, `rustup component add rust-analyzer` for rust-analyzer. A version mismatch between the server and the compiler can cause subtle failures (wrong module resolution, missing APIs). Use Homebrew when the server is independent of a language runtime (e.g. `lua-language-server`, `clangd`) — no version coupling means no risk. When in doubt, check the server's own install docs; if they lead with a language-specific method, use that.

### 4. Enable the LSP server

Add two lines near the existing `rust_analyzer` block in `init.lua`:
```lua
vim.lsp.config('<server_name>', {})  -- add settings inside {} if needed
vim.lsp.enable('<server_name>')
```
The server name must match the lspconfig name exactly (e.g. `gopls`, `pyright`, `clangd`).

### 5. (Optional) Adjust indentation

If the language uses non-default indentation, add its filetype to the existing `FileType` autocmd or create a new one.

---

## Example: Go

```sh
# system terminal
go install golang.org/x/tools/gopls@latest
```

```
:TSInstall go
```

In `init.lua`:
```lua
-- in the queries table:
go = '[(function_declaration)(method_declaration)] @fn',

-- near the rust_analyzer block:
vim.lsp.config('gopls', {})
vim.lsp.enable('gopls')
```

Go uses tabs by default, so no indentation change is needed.
