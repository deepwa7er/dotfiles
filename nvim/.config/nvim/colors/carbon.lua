-- carbon.lua
-- IBM Carbon Design System colorscheme for Neovim
-- Based on the Color Anatomy palette from carbondesignsystem.com/elements/color/overview/
--
-- Primary palette: blue ramp + gray ramp
-- Accent palette:  four Carbon alert colors (red, orange, yellow, green)
--
-- Philosophy: monochromatic blues + blacks for syntax structure;
-- alert colors used sparingly for literals and diagnostics only.

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'carbon'
vim.o.background = 'dark'

-- ── Palette ───────────────────────────────────────────────────────────────────
-- Blue ramp (dark → light), from Carbon Color Anatomy
local blue = {
  b100 = '#001141', -- near-black blue
  b90  = '#001d6c',
  b80  = '#002d9c',
  b70  = '#0043ce',
  b60  = '#0f62fe', -- IBM Blue (interactive)
  b50  = '#4589ff',
  b40  = '#78a9ff', -- primary syntax blue
  b30  = '#a6c8ff', -- lighter syntax blue
  b20  = '#d0e2ff', -- pale blue (params, namespaces)
  b10  = '#edf5ff',
}

-- Gray ramp (dark → light), from Carbon Color Anatomy
local gray = {
  g100 = '#161616', -- editor background
  g90  = '#262626', -- panels / floats
  g80  = '#393939', -- hover / selection layers
  g70  = '#525252', -- subtle fills
  g60  = '#6f6f6f', -- comments
  g50  = '#8d8d8d', -- operators, muted UI
  g40  = '#a8a8a8', -- disabled
  g30  = '#c6c6c6', -- secondary text, properties
  g20  = '#e0e0e0',
  g10  = '#f4f4f4', -- primary text
}

-- Alert colors (from Carbon Color Anatomy — used sparingly)
local alert = {
  red    = '#da1e28', -- error
  orange = '#ff832b', -- warning / numbers
  yellow = '#fddc69', -- caution / booleans / search
  green  = '#24a148', -- success / strings
}

-- Derived tinted backgrounds for virtual text and diff
local tint = {
  red    = '#2d0a0b',
  orange = '#2d1800',
  yellow = '#252008',
  green  = '#071c0c',
  blue   = '#00103d',
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor UI ─────────────────────────────────────────────────────────────────
hi('Normal',          { fg = gray.g10,  bg = gray.g100 })
hi('NormalFloat',     { fg = gray.g10,  bg = gray.g90 })
hi('FloatBorder',     { fg = gray.g60,  bg = gray.g90 })
hi('FloatTitle',      { fg = blue.b40,  bg = gray.g90,  bold = true })

hi('Cursor',          { fg = gray.g100, bg = gray.g10 })
hi('CursorLine',      { bg = gray.g90 })
hi('CursorColumn',    { bg = gray.g90 })
hi('CursorLineNr',    { fg = gray.g10,  bg = gray.g90,  bold = true })
hi('LineNr',          { fg = gray.g60 })
hi('LineNrAbove',     { fg = gray.g60 })
hi('LineNrBelow',     { fg = gray.g60 })

hi('SignColumn',      { fg = gray.g60,  bg = gray.g100 })
hi('FoldColumn',      { fg = gray.g60,  bg = gray.g100 })
hi('ColorColumn',     { bg = gray.g90 })

hi('StatusLine',      { fg = gray.g30,  bg = gray.g90 })
hi('StatusLineNC',    { fg = gray.g60,  bg = gray.g90 })
hi('TabLine',         { fg = gray.g50,  bg = gray.g90 })
hi('TabLineSel',      { fg = gray.g10,  bg = gray.g100, bold = true })
hi('TabLineFill',     { bg = gray.g90 })

hi('WinSeparator',    { fg = gray.g80 })
hi('VertSplit',       { fg = gray.g80 })

hi('Pmenu',           { fg = gray.g30,  bg = gray.g90 })
hi('PmenuSel',        { fg = gray.g10,  bg = gray.g80 })
hi('PmenuSbar',       { bg = gray.g90 })
hi('PmenuThumb',      { bg = gray.g80 })
hi('PmenuKind',       { fg = blue.b40,  bg = gray.g90 })
hi('PmenuKindSel',    { fg = blue.b40,  bg = gray.g80 })
hi('PmenuExtra',      { fg = gray.g60,  bg = gray.g90 })
hi('PmenuExtraSel',   { fg = gray.g50,  bg = gray.g80 })

-- Visual: dark blue tint (blue80) — clearly intentional, from the blue ramp
hi('Visual',          { bg = blue.b80 })
hi('VisualNOS',       { bg = blue.b80 })

-- Search: yellow alert — high visibility
hi('Search',          { fg = gray.g100, bg = alert.yellow })
hi('IncSearch',       { fg = gray.g100, bg = alert.yellow, bold = true })
hi('CurSearch',       { fg = gray.g100, bg = alert.yellow, bold = true })
hi('Substitute',      { fg = gray.g10,  bg = alert.red })

hi('MatchParen',      { fg = blue.b20,  bold = true })

hi('NonText',         { fg = gray.g80 })
hi('Whitespace',      { fg = gray.g80 })
hi('EndOfBuffer',     { fg = gray.g90 })
hi('SpecialKey',      { fg = gray.g60 })
hi('Conceal',         { fg = gray.g60 })

hi('Folded',          { fg = gray.g50,  bg = gray.g90 })

hi('Directory',       { fg = blue.b40 })
hi('Title',           { fg = blue.b40,  bold = true })
hi('Question',        { fg = alert.green })
hi('MoreMsg',         { fg = alert.green })
hi('ModeMsg',         { fg = gray.g30 })
hi('ErrorMsg',        { fg = alert.red })
hi('WarningMsg',      { fg = alert.orange })

hi('SpellBad',        { undercurl = true, sp = alert.red })
hi('SpellCap',        { undercurl = true, sp = alert.yellow })
hi('SpellRare',       { undercurl = true, sp = blue.b40 })
hi('SpellLocal',      { undercurl = true, sp = blue.b30 })

hi('QuickFixLine',    { bg = gray.g80 })
hi('WildMenu',        { fg = gray.g10,  bg = gray.g80 })

-- ── Syntax ────────────────────────────────────────────────────────────────────

-- Comments: gray60, muted and italic
hi('Comment',         { fg = gray.g60,  italic = true })

-- Identifiers: plain text, no color
hi('Identifier',      { fg = gray.g10 })

-- Strings: green alert — the one alert color in everyday syntax
hi('String',          { fg = alert.green })
hi('Character',       { fg = alert.green })

-- Numbers: orange alert
hi('Number',          { fg = alert.orange })
hi('Float',           { fg = alert.orange })

-- Booleans / nil / null: yellow alert
hi('Boolean',         { fg = alert.yellow })

-- All other constants: pale blue
hi('Constant',        { fg = blue.b20 })

-- Functions: blue30 — lighter than keywords
hi('Function',        { fg = blue.b30 })

-- Keywords / control flow: blue40 — the dominant syntax blue
hi('Statement',       { fg = blue.b40 })
hi('Conditional',     { fg = blue.b40 })
hi('Repeat',          { fg = blue.b40 })
hi('Label',           { fg = blue.b40 })
hi('Keyword',         { fg = blue.b40 })
hi('Exception',       { fg = blue.b40 })

-- Operators: gray50 — recede into background
hi('Operator',        { fg = gray.g50 })

-- Preprocessor / macros: blue30 (same family as functions)
hi('PreProc',         { fg = blue.b30 })
hi('Include',         { fg = blue.b40 })
hi('Define',          { fg = blue.b30 })
hi('Macro',           { fg = blue.b30 })
hi('PreCondit',       { fg = blue.b30 })

-- Types / structures: blue50 — slightly richer blue
hi('Type',            { fg = blue.b50 })
hi('StorageClass',    { fg = blue.b40 })
hi('Structure',       { fg = blue.b50 })
hi('Typedef',         { fg = blue.b50 })

-- Delimiters / punctuation: gray30
hi('Delimiter',       { fg = gray.g30 })
hi('Special',         { fg = blue.b20 })
hi('SpecialChar',     { fg = alert.orange })
hi('Tag',             { fg = blue.b40 })
hi('SpecialComment',  { fg = gray.g50,  italic = true })
hi('Debug',           { fg = alert.red })

hi('Underlined',      { underline = true })
hi('Ignore',          { fg = gray.g60 })
hi('Error',           { fg = alert.red })
hi('Todo',            { fg = gray.g100, bg = alert.yellow, bold = true })

-- ── Treesitter ────────────────────────────────────────────────────────────────

-- Comments
hi('@comment',                     { fg = gray.g60,   italic = true })
hi('@comment.documentation',       { fg = gray.g50,   italic = true })
hi('@comment.error',               { fg = alert.red,  bold = true, italic = true })
hi('@comment.warning',             { fg = alert.orange, bold = true, italic = true })
hi('@comment.todo',                { fg = gray.g100,  bg = alert.yellow, bold = true })
hi('@comment.note',                { fg = blue.b30,   bold = true, italic = true })

-- Keywords: blue40 (the main syntax blue)
hi('@keyword',                     { fg = blue.b40 })
hi('@keyword.function',            { fg = blue.b40 })
hi('@keyword.operator',            { fg = blue.b40 })
hi('@keyword.return',              { fg = blue.b40 })
hi('@keyword.import',              { fg = blue.b40 })
hi('@keyword.modifier',            { fg = blue.b40 })
hi('@keyword.repeat',              { fg = blue.b40 })
hi('@keyword.exception',           { fg = blue.b40 })
hi('@keyword.conditional',         { fg = blue.b40 })
hi('@keyword.conditional.ternary', { fg = blue.b40 })
hi('@keyword.directive',           { fg = blue.b30 })
hi('@keyword.directive.define',    { fg = blue.b30 })

-- Operators / punctuation: gray tones, recede
hi('@operator',                    { fg = gray.g50 })
hi('@punctuation.bracket',         { fg = gray.g30 })
hi('@punctuation.delimiter',       { fg = gray.g30 })
hi('@punctuation.special',         { fg = blue.b20 })

-- Strings: green alert
hi('@string',                      { fg = alert.green })
hi('@string.escape',               { fg = alert.orange })   -- escape seqs pop within strings
hi('@string.special',              { fg = alert.orange })
hi('@string.special.url',          { fg = blue.b40,  underline = true })
hi('@string.regexp',               { fg = alert.orange })

-- Characters / numbers / booleans
hi('@character',                   { fg = alert.green })
hi('@character.special',           { fg = alert.orange })
hi('@number',                      { fg = alert.orange })
hi('@number.float',                { fg = alert.orange })
hi('@boolean',                     { fg = alert.yellow })

-- Functions: blue30 — lighter than keywords
hi('@function',                    { fg = blue.b30 })
hi('@function.builtin',            { fg = blue.b30,  italic = true })
hi('@function.call',               { fg = blue.b30 })
hi('@function.macro',              { fg = blue.b30 })
hi('@function.method',             { fg = blue.b30 })
hi('@function.method.call',        { fg = blue.b30 })

-- Constructor: blue50 (like types)
hi('@constructor',                 { fg = blue.b50 })

-- Variables: plain text — no special color, they are the baseline
hi('@variable',                    { fg = gray.g10 })
hi('@variable.builtin',            { fg = blue.b20,  italic = true })  -- self, this, etc.
hi('@variable.parameter',          { fg = blue.b20 })                  -- pale blue params
hi('@variable.parameter.builtin',  { fg = blue.b20,  italic = true })
hi('@variable.member',             { fg = gray.g30 })                  -- obj fields, gray

-- Modules / namespaces: pale blue — informational, not structural
hi('@module',                      { fg = blue.b20 })
hi('@module.builtin',              { fg = blue.b20,  italic = true })

-- Labels
hi('@label',                       { fg = blue.b40 })

-- Types: blue50
hi('@type',                        { fg = blue.b50 })
hi('@type.builtin',                { fg = blue.b50,  italic = true })
hi('@type.definition',             { fg = blue.b50 })
hi('@type.qualifier',              { fg = blue.b40 })

-- Attributes / decorators: yellow alert (rare, should catch the eye)
hi('@attribute',                   { fg = alert.yellow })
hi('@attribute.builtin',           { fg = alert.yellow, italic = true })

-- Constants: pale blue; builtins (nil/None/null) get yellow alert
hi('@constant',                    { fg = blue.b20 })
hi('@constant.builtin',            { fg = alert.yellow })
hi('@constant.macro',              { fg = blue.b30 })

-- Markup (Markdown / RST)
hi('@markup.heading',              { fg = blue.b40,  bold = true })
hi('@markup.heading.1',            { fg = blue.b40,  bold = true })
hi('@markup.heading.2',            { fg = blue.b50,  bold = true })
hi('@markup.heading.3',            { fg = blue.b30,  bold = true })
hi('@markup.heading.4',            { fg = blue.b20,  bold = true })
hi('@markup.heading.5',            { fg = blue.b20 })
hi('@markup.heading.6',            { fg = gray.g30 })
hi('@markup.italic',               { italic = true })
hi('@markup.strong',               { bold = true })
hi('@markup.underline',            { underline = true })
hi('@markup.strikethrough',        { strikethrough = true })
hi('@markup.quote',                { fg = gray.g50,  italic = true })
hi('@markup.math',                 { fg = blue.b30 })
hi('@markup.link',                 { fg = blue.b40,  underline = true })
hi('@markup.link.label',           { fg = blue.b30 })
hi('@markup.link.url',             { fg = blue.b20,  underline = true })
hi('@markup.raw',                  { fg = alert.green })
hi('@markup.raw.block',            { fg = alert.green })
hi('@markup.list',                 { fg = blue.b40 })
hi('@markup.list.checked',         { fg = alert.green })
hi('@markup.list.unchecked',       { fg = gray.g50 })

-- HTML / JSX tags: blues
hi('@tag',                         { fg = blue.b40 })
hi('@tag.builtin',                 { fg = blue.b40,  italic = true })
hi('@tag.attribute',               { fg = blue.b30 })
hi('@tag.delimiter',               { fg = gray.g30 })

-- ── LSP semantic tokens ───────────────────────────────────────────────────────
hi('@lsp.type.class',              { link = '@type' })
hi('@lsp.type.decorator',          { link = '@attribute' })
hi('@lsp.type.enum',               { link = '@type' })
hi('@lsp.type.enumMember',         { link = '@constant' })
hi('@lsp.type.function',           { link = '@function' })
hi('@lsp.type.interface',          { fg = blue.b50,  italic = true })
hi('@lsp.type.macro',              { link = '@function.macro' })
hi('@lsp.type.method',             { link = '@function.method' })
hi('@lsp.type.namespace',          { link = '@module' })
hi('@lsp.type.parameter',          { link = '@variable.parameter' })
hi('@lsp.type.property',           { link = '@variable.member' })
hi('@lsp.type.struct',             { link = '@type' })
hi('@lsp.type.type',               { link = '@type' })
hi('@lsp.type.typeParameter',      { fg = blue.b20 })
hi('@lsp.type.variable',           { link = '@variable' })
hi('@lsp.type.keyword',            { link = '@keyword' })
hi('@lsp.type.comment',            { link = '@comment' })
hi('@lsp.type.string',             { link = '@string' })
hi('@lsp.type.number',             { link = '@number' })
hi('@lsp.type.operator',           { link = '@operator' })
hi('@lsp.type.selfKeyword',        { link = '@variable.builtin' })
hi('@lsp.type.builtinType',        { link = '@type.builtin' })
hi('@lsp.mod.deprecated',          { strikethrough = true })
hi('@lsp.mod.readonly',            { fg = blue.b20 })

-- ── Diagnostics ───────────────────────────────────────────────────────────────
-- All four alert colors in their natural roles
hi('DiagnosticError',              { fg = alert.red })
hi('DiagnosticWarn',               { fg = alert.orange })
hi('DiagnosticInfo',               { fg = blue.b50 })
hi('DiagnosticHint',               { fg = blue.b30 })
hi('DiagnosticOk',                 { fg = alert.green })

hi('DiagnosticUnderlineError',     { undercurl = true, sp = alert.red })
hi('DiagnosticUnderlineWarn',      { undercurl = true, sp = alert.orange })
hi('DiagnosticUnderlineInfo',      { undercurl = true, sp = blue.b50 })
hi('DiagnosticUnderlineHint',      { undercurl = true, sp = blue.b30 })
hi('DiagnosticUnderlineOk',        { undercurl = true, sp = alert.green })

hi('DiagnosticVirtualTextError',   { fg = alert.red,    bg = tint.red })
hi('DiagnosticVirtualTextWarn',    { fg = alert.orange, bg = tint.orange })
hi('DiagnosticVirtualTextInfo',    { fg = blue.b50,     bg = tint.blue })
hi('DiagnosticVirtualTextHint',    { fg = blue.b30,     bg = tint.blue })
hi('DiagnosticVirtualTextOk',      { fg = alert.green,  bg = tint.green })

hi('DiagnosticSignError',          { fg = alert.red })
hi('DiagnosticSignWarn',           { fg = alert.orange })
hi('DiagnosticSignInfo',           { fg = blue.b50 })
hi('DiagnosticSignHint',           { fg = blue.b30 })

hi('DiagnosticFloatingError',      { fg = alert.red,    bg = gray.g90 })
hi('DiagnosticFloatingWarn',       { fg = alert.orange, bg = gray.g90 })
hi('DiagnosticFloatingInfo',       { fg = blue.b50,     bg = gray.g90 })
hi('DiagnosticFloatingHint',       { fg = blue.b30,     bg = gray.g90 })

-- ── LSP UI ────────────────────────────────────────────────────────────────────
hi('LspReferenceText',             { bg = gray.g80 })
hi('LspReferenceRead',             { bg = gray.g80 })
hi('LspReferenceWrite',            { bg = gray.g80,  bold = true })
hi('LspInlayHint',                 { fg = gray.g60,  bg = gray.g90,  italic = true })
hi('LspCodeLens',                  { fg = gray.g60,  italic = true })
hi('LspCodeLensSeparator',         { fg = gray.g70 })
hi('LspSignatureActiveParameter',  { fg = alert.yellow, bold = true })

-- ── Diff ──────────────────────────────────────────────────────────────────────
hi('DiffAdd',                      { fg = alert.green,  bg = tint.green })
hi('DiffChange',                   { fg = alert.yellow, bg = tint.yellow })
hi('DiffDelete',                   { fg = alert.red,    bg = tint.red })
hi('DiffText',                     { fg = alert.orange, bg = tint.orange, bold = true })

hi('Added',                        { fg = alert.green })
hi('Changed',                      { fg = alert.yellow })
hi('Removed',                      { fg = alert.red })
