vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd('colorscheme reticle')

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.o.mouse = 'a'
vim.o.swapfile = false

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.scrolloff = 5

vim.o.confirm = true

vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '<S-h>', ':bprev<CR>', { desc = 'Go to previous buffer' })

vim.keymap.set('n', '<Esc>', '<cmd><CR>', { desc = 'Go to previous buffer' })

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site/')

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'lua', 'html', 'js', 'jsx', 'ts', 'tsx' },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})


-- TREESITTER

local function jump_to_function(direction)
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.bo[bufnr].filetype

  local queries = {
    rust       = '(function_item) @fn',
    python     = '(function_definition) @fn',
    c          = '(function_definition) @fn',
    lua        = '[(function_definition)(local_function)] @fn',
    javascript = '[(function_declaration)(method_definition)] @fn',
    typescript = '[(function_declaration)(method_definition)] @fn',
    go = '(function_declaration) @fn'
  }

  local query_str = queries[ft]
  if not query_str then return end

  local ok, query = pcall(vim.treesitter.query.parse, ft, query_str)
  if not ok then return end

  local parser = vim.treesitter.get_parser(bufnr, ft)
  local root = parser:parse()[1]:root()
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1

  local rows = {}
  for _, node in query:iter_captures(root, bufnr) do
    local row = node:start()
    table.insert(rows, row)
  end
  table.sort(rows)

  if direction == 'next' then
    for _, row in ipairs(rows) do
      if row > cursor_row then
        vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
        return
      end
    end
  else
    for i = #rows, 1, -1 do
      if rows[i] < cursor_row then
        vim.api.nvim_win_set_cursor(0, { rows[i] + 1, 0 })
        return
      end
    end
  end
end

-- KEYMAPS

vim.keymap.set('n', ']f', function() jump_to_function('next') end, { desc = 'Jump to next function' })
vim.keymap.set('n', '[f', function() jump_to_function('prev') end, { desc = 'Jump to previous function' })

vim.keymap.set('n', '<space><space>x', "<cmd>source %<CR>", { desc = 'Source file in current buffer'})
vim.keymap.set('n', '<space>x', ":.lua<CR>", { desc = 'Source current line'})
vim.keymap.set('v', '<space>x', ":lua<CR>", { desc = 'Source highlighted section'})

-- KEYBIND HELP

vim.keymap.set('n', '<leader>h', function()
  local init_sid = nil
  for _, info in ipairs(vim.fn.getscriptinfo()) do
    if info.name:match('init%.lua$') then
      init_sid = info.sid
      break
    end
  end

  local modes = { n = 'n', v = 'v', x = 'x', i = 'i' }
  local custom, other = {}, {}

  for mode_short, mode_label in pairs(modes) do
    for _, map in ipairs(vim.api.nvim_get_keymap(mode_short)) do
      if map.desc and map.desc ~= '' then
        local line = string.format('  %-6s %-20s %s', mode_label, map.lhs, map.desc)
        if map.sid == init_sid then
          table.insert(custom, line)
        else
          table.insert(other, line)
        end
      end
    end
  end

  table.sort(custom)
  table.sort(other)

  local lines = {}
  if #custom > 0 then
    table.insert(lines, '  -- custom --')
    vim.list_extend(lines, custom)
  end
  if #other > 0 then
    table.insert(lines, '')
    table.insert(lines, '  -- builtin --')
    vim.list_extend(lines, other)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(#lines, vim.o.lines - 4)
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Keymaps ',
    title_pos = 'center',
  })

  vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = buf, silent = true })
end, { desc = 'Show all keymaps' })

-- GREP

vim.o.grepprg = 'rg --vimgrep --smart-case'
vim.o.grepformat = '%f:%l:%c:%m'

vim.keymap.set('n', '<leader>g', function()
  vim.ui.input({ prompt = 'Grep: ' }, function(pattern)
    if pattern and pattern ~= '' then
      vim.cmd('grep! ' .. vim.fn.shellescape(pattern))
      vim.cmd('copen')
    end
  end)
end, { desc = 'Grep project' })

vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Prev quickfix item' })
vim.keymap.set('n', '<leader>i', ':lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', { desc = 'Enable inlay hints' })
vim.keymap.set('n', '<leader>rd', function()
    vim.lsp.buf.execute_command({ command = 'rust-analyzer.openDocs' })
  end, { desc = 'Open docs.rs' })

  -- View syntax tree (debug)
  vim.keymap.set('n', '<leader>rst', function()
    vim.lsp.buf.execute_command({ command = 'rust-analyzer.syntaxTree' })
  end, { desc = 'View syntax tree' })
-- PLUGINS

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig'
})


vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      }
    }
  }
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('gopls', {})  -- add settings inside {} if needed
vim.lsp.enable('gopls')

vim.o.completeopt = 'menuone,noselect,noinsert'

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/completion') then
      -- Enable native completion and autotriggering
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end
})

-- Enables on-type formatting for Rust
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client_id = ev.data.client_id
    local client = assert(vim.lsp.get_client_by_id(client_id))
    if client.name == 'rust-analyzer' then
      vim.lsp.on_type_formatting.enable(true, { client_id = client_id })
    end
  end,
})

vim.diagnostic.config({ virtual_lines = true, severity_sort = true, float = { border = "square", source = "true" } })

vim.keymap.set('n', '<leader>dl', function()
  local current = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = 'Toggle diagnostic virtual lines' })

-- rust-analyzer LSP extensions (custom request methods, not workspace/executeCommand)
local function ra_request(method, params, handler)
  local clients = vim.lsp.get_clients({ name = 'rust_analyzer', bufnr = 0 })
  if #clients == 0 then
    vim.notify('rust-analyzer not attached', vim.log.levels.WARN)
    return
  end
  clients[1]:request(method, params, handler, 0)
end

vim.keymap.set('n', '<leader>rd', function()
  ra_request('experimental/externalDocs', vim.lsp.util.make_position_params(), function(err, url)
    if err then vim.notify(err.message, vim.log.levels.ERROR); return end
    if url then vim.ui.open(url) end
  end)
end, { desc = 'Open docs.rs' })

-- output is shitty
vim.keymap.set('n', '<leader>rst', function()
  local params = { textDocument = vim.lsp.util.make_text_document_params() }
  ra_request('rust-analyzer/viewSyntaxTree', params, function(err, result)
    if err then vim.notify(err.message, vim.log.levels.ERROR); return end
    if not result then return end
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, '\n'))
    vim.cmd('vsplit')
    vim.api.nvim_win_set_buf(0, buf)
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, silent = true })
  end)
end, { desc = 'View syntax tree' })

print("init.lua loaded")


