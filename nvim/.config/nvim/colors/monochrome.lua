-- monochrome.lua
-- Native Neovim port of monochrome.lua (originally written with colorbuddy)

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'monochrome'
vim.o.background = 'dark'

local c = {
  background = '#181818',
  black      = '#000000',
  gray       = '#808080',
  dark_gray  = '#1e1e1e',
  light_gray = '#828282',
  white      = '#cccccc',
  red        = '#FF405C',
  pink       = '#e63e62',
  green      = '#93C37C',
  brown      = '#dea661',
  blue       = '#77b5fe',
  comment    = '#9292ec',
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- White
hi('Normal',       { fg = c.white,      bg = c.background })
hi('Constant',     { fg = c.white,      bg = c.background })
hi('Function',     { fg = c.white,      bg = c.background })
hi('Character',    { fg = c.white,      bg = c.background })
hi('SpecialChar',  { fg = c.white,      bg = c.background })
hi('Number',       { fg = c.white,      bg = c.background })
hi('Float',        { fg = c.white,      bg = c.background })
hi('FloatBorder',  { fg = c.white,      bg = c.background })
hi('Structure',    { fg = c.white,      bg = c.background })
hi('Identifier',   { fg = c.white,      bg = c.background })
hi('Statement',    { fg = c.white,      bg = c.background })
hi('SignColumn',   { fg = c.white,      bg = c.background })
hi('FoldColumn',   { fg = c.white,      bg = c.background })
hi('Operator',     { fg = c.white,      bg = c.background })
hi('Whitespace',   { fg = c.white,      bg = c.background })
hi('Tag',          { fg = c.white,      bg = c.background })

-- Gray (Special defined twice in original — gray wins)
hi('Special',      { fg = c.gray,       bg = c.background })
hi('LineNr',       { fg = c.gray,       bg = c.background })

-- Dark gray
hi('Module',       { fg = c.dark_gray,  bg = c.background })

-- Light gray
hi('PreProc',      { fg = c.light_gray, bg = c.background })
hi('Type',         { fg = c.light_gray, bg = c.background })
hi('@type.builtin',{ fg = c.light_gray, bg = c.background })
hi('Underlined',   { fg = c.light_gray, bg = c.background, underline = true })
hi('StatusLine',   { fg = c.light_gray, bg = c.background })

-- Todo
hi('Todo',         { fg = c.black,      bg = c.gray })

-- Visual
hi('Visual',       { fg = c.red,        bg = c.background })

-- String
hi('String',       { fg = c.green,      bg = c.background })

-- Blue (keywords, cursor, search)
hi('Keyword',                        { fg = c.blue })
hi('@keyword',                       { fg = c.blue })
hi('@keyword.repeat',                { fg = c.blue })
hi('@keyword.conditional',           { fg = c.blue })
hi('@keyword.return',                { fg = c.blue })
hi('@keyword.modifier',              { fg = c.blue })
hi('@keyword.type',                  { fg = c.blue })
hi('@keyword.operator',              { fg = c.blue })
hi('@keyword.directive',             { fg = c.blue })
hi('@keyword.directive.define',      { fg = c.blue })
hi('@keyword.import',                { fg = c.blue })
hi('@keyword.conditional.ternary',   { fg = c.blue })
hi('MatchParen',                     { fg = c.blue })
hi('Search',                         { fg = c.blue })
hi('lCursor',                        { fg = c.blue, bg = c.blue })
hi('Cursor',                         { fg = c.blue })
hi('CursorIM',                       { fg = c.blue })
hi('CursorLineNr',                   { fg = c.blue, bg = c.background })

-- Comments
hi('Comment',      { fg = c.comment,    italic = true })

-- Diagnostics (no foreground — intentionally invisible/inherited)
hi('Diagnostic',       { bg = c.background })
hi('DiagnosticError',  { bg = c.background })
hi('DiagnosticWarn',   { bg = c.background })
hi('DiagnosticInfo',   { bg = c.background })
hi('DiagnosticHint',   { bg = c.background })
hi('DiagnosticOk',     { bg = c.background })

hi('NormalFloat',  { bg = c.background })
hi('CursorLine',   {})  -- cleared; no fg, no bg

-- Transparent background (terminal bg shows through)
vim.cmd([[
  highlight Normal    guibg=none
  highlight NonText   guibg=none
  highlight Normal    ctermbg=none
  highlight NonText   ctermbg=none
]])
