-- arctic.lua
-- Minimalist arctic frost colorscheme for Neovim
--
-- Philosophy: deep blue-black backgrounds, icy blue ramp for syntax structure,
-- four aurora accent colors used sparingly for literals and diagnostics.

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'arctic'
vim.o.background = 'dark'

-- ── Palette ───────────────────────────────────────────────────────────────────

-- Deep blue-black backgrounds (frozen midnight sky)
local bg = {
  base   = '#181818', -- editor background
  panel  = '#181818', -- panels, floats
  select = '#1c2d3f', -- hover, selection layers
  fill   = '#253649', -- subtle fills
}

-- Frost ramp: blue-tinted gray-whites (dark → light)
local frost = {
  f70 = '#527a96', -- comments, muted
  f60 = '#6e96b0', -- operators, muted UI
  f50 = '#8ab0c8', -- secondary text
  f40 = '#a8c8da', -- properties, field names
  f30 = '#c4d8e8', -- lighter secondary
  f20 = '#dceef8', -- pale blue-white
  f10 = '#f0f8ff', -- near-white primary text
}

-- Ice blue ramp: active interactive blues (dark → light)
local ice = {
  i60 = '#1c4a8c', -- deep blue
  i50 = '#4a90d4', -- type blue
  i40 = '#60aae8', -- keyword blue (interactive)
  i30 = '#8cc8f5', -- function blue
  i20 = '#b8dcf8', -- parameter blue
  i10 = '#d8eefa', -- pale blue
}

-- Aurora accents (four roles, used sparingly)
local aurora = {
  cyan   = '#3dd8d8', -- strings  — vivid icy teal
  amber  = '#f5b040', -- numbers  — warm amber
  purple = '#c0a8f8', -- booleans — aurora violet
  red    = '#f07272', -- errors   — frost red
  green  = '#7ad89a', -- success  — icy green
}

-- Tinted backgrounds for virtual text / diff
local tint = {
  red    = '#2a0f0f',
  amber  = '#2a1a05',
  purple = '#1a1530',
  cyan   = '#052525',
  green  = '#0a2015',
  blue   = '#0a1a30',
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor UI ─────────────────────────────────────────────────────────────────
hi('Normal',          { fg = frost.f10,  bg = bg.base })
hi('NormalFloat',     { fg = frost.f10,  bg = bg.panel })
hi('FloatBorder',     { fg = frost.f60,  bg = bg.panel })
hi('FloatTitle',      { fg = ice.i40,    bg = bg.panel,  bold = true })

hi('Cursor',          { fg = bg.base,    bg = frost.f10 })
hi('CursorLine',      { bg = bg.panel })
hi('CursorColumn',    { bg = bg.panel })
hi('CursorLineNr',    { fg = frost.f10,  bg = bg.panel,  bold = true })
hi('LineNr',          { fg = frost.f70 })
hi('LineNrAbove',     { fg = frost.f70 })
hi('LineNrBelow',     { fg = frost.f70 })

hi('SignColumn',      { fg = frost.f70,  bg = bg.base })
hi('FoldColumn',      { fg = frost.f70,  bg = bg.base })
hi('ColorColumn',     { bg = bg.panel })

hi('StatusLine',      { fg = frost.f40,  bg = bg.panel })
hi('StatusLineNC',    { fg = frost.f70,  bg = bg.panel })
hi('TabLine',         { fg = frost.f60,  bg = bg.panel })
hi('TabLineSel',      { fg = frost.f10,  bg = bg.base,   bold = true })
hi('TabLineFill',     { bg = bg.panel })

hi('WinSeparator',    { fg = bg.select })
hi('VertSplit',       { fg = bg.select })

hi('Pmenu',           { fg = frost.f40,  bg = bg.panel })
hi('PmenuSel',        { fg = frost.f10,  bg = bg.select })
hi('PmenuSbar',       { bg = bg.panel })
hi('PmenuThumb',      { bg = bg.select })
hi('PmenuKind',       { fg = ice.i40,    bg = bg.panel })
hi('PmenuKindSel',    { fg = ice.i40,    bg = bg.select })
hi('PmenuExtra',      { fg = frost.f70,  bg = bg.panel })
hi('PmenuExtraSel',   { fg = frost.f60,  bg = bg.select })

-- Visual: deep ice blue tint
hi('Visual',          { bg = ice.i60 })
hi('VisualNOS',       { bg = ice.i60 })

-- Search: amber — high visibility against dark bg
hi('Search',          { fg = bg.base,    bg = aurora.amber })
hi('IncSearch',       { fg = bg.base,    bg = aurora.amber, bold = true })
hi('CurSearch',       { fg = bg.base,    bg = aurora.amber, bold = true })
hi('Substitute',      { fg = frost.f10,  bg = aurora.red })

hi('MatchParen',      { fg = ice.i10,    bold = true })

hi('NonText',         { fg = bg.select })
hi('Whitespace',      { fg = bg.select })
hi('EndOfBuffer',     { fg = bg.panel })
hi('SpecialKey',      { fg = frost.f70 })
hi('Conceal',         { fg = frost.f70 })

hi('Folded',          { fg = frost.f60,  bg = bg.panel })

hi('Directory',       { fg = ice.i40 })
hi('Title',           { fg = ice.i40,    bold = true })
hi('Question',        { fg = aurora.green })
hi('MoreMsg',         { fg = aurora.green })
hi('ModeMsg',         { fg = frost.f40 })
hi('ErrorMsg',        { fg = aurora.red })
hi('WarningMsg',      { fg = aurora.amber })

hi('SpellBad',        { undercurl = true, sp = aurora.red })
hi('SpellCap',        { undercurl = true, sp = aurora.amber })
hi('SpellRare',       { undercurl = true, sp = ice.i40 })
hi('SpellLocal',      { undercurl = true, sp = ice.i30 })

hi('QuickFixLine',    { bg = bg.select })
hi('WildMenu',        { fg = frost.f10,  bg = bg.select })

-- ── Syntax ────────────────────────────────────────────────────────────────────

-- Comments: muted frost, italic
hi('Comment',         { fg = frost.f70,  italic = true })

-- Identifiers: plain text
hi('Identifier',      { fg = frost.f10 })

-- Strings: icy cyan
hi('String',          { fg = aurora.cyan })
hi('Character',       { fg = aurora.cyan })

-- Numbers: warm amber (contrast against the cold palette)
hi('Number',          { fg = aurora.amber })
hi('Float',           { fg = aurora.amber })

-- Booleans / nil / null: aurora purple
hi('Boolean',         { fg = aurora.purple })

-- Constants: pale blue-white
hi('Constant',        { fg = ice.i10 })

-- Functions: ice30 — lighter than keywords
hi('Function',        { fg = ice.i30 })

-- Keywords / control flow: ice40 — the dominant syntax blue
hi('Statement',       { fg = ice.i40 })
hi('Conditional',     { fg = ice.i40 })
hi('Repeat',          { fg = ice.i40 })
hi('Label',           { fg = ice.i40 })
hi('Keyword',         { fg = ice.i40 })
hi('Exception',       { fg = ice.i40 })

-- Operators: frost60 — recede into background
hi('Operator',        { fg = frost.f60 })

-- Preprocessor / macros: ice30
hi('PreProc',         { fg = ice.i30 })
hi('Include',         { fg = ice.i40 })
hi('Define',          { fg = ice.i30 })
hi('Macro',           { fg = ice.i30 })
hi('PreCondit',       { fg = ice.i30 })

-- Types: ice50
hi('Type',            { fg = ice.i50 })
hi('StorageClass',    { fg = ice.i40 })
hi('Structure',       { fg = ice.i50 })
hi('Typedef',         { fg = ice.i50 })

-- Delimiters / punctuation: frost30
hi('Delimiter',       { fg = frost.f30 })
hi('Special',         { fg = ice.i10 })
hi('SpecialChar',     { fg = aurora.amber })
hi('Tag',             { fg = ice.i40 })
hi('SpecialComment',  { fg = frost.f60,  italic = true })
hi('Debug',           { fg = aurora.red })

hi('Underlined',      { underline = true })
hi('Ignore',          { fg = frost.f70 })
hi('Error',           { fg = aurora.red })
hi('Todo',            { fg = bg.base,    bg = aurora.amber, bold = true })

-- ── Treesitter ────────────────────────────────────────────────────────────────

-- Comments
hi('@comment',                     { fg = frost.f70,   italic = true })
hi('@comment.documentation',       { fg = frost.f60,   italic = true })
hi('@comment.error',               { fg = aurora.red,  bold = true, italic = true })
hi('@comment.warning',             { fg = aurora.amber, bold = true, italic = true })
hi('@comment.todo',                { fg = bg.base,     bg = aurora.amber, bold = true })
hi('@comment.note',                { fg = ice.i30,     bold = true, italic = true })

-- Keywords: ice40
hi('@keyword',                     { fg = ice.i40 })
hi('@keyword.function',            { fg = ice.i40 })
hi('@keyword.operator',            { fg = ice.i40 })
hi('@keyword.return',              { fg = ice.i40 })
hi('@keyword.import',              { fg = ice.i40 })
hi('@keyword.modifier',            { fg = ice.i40 })
hi('@keyword.repeat',              { fg = ice.i40 })
hi('@keyword.exception',           { fg = ice.i40 })
hi('@keyword.conditional',         { fg = ice.i40 })
hi('@keyword.conditional.ternary', { fg = ice.i40 })
hi('@keyword.directive',           { fg = ice.i30 })
hi('@keyword.directive.define',    { fg = ice.i30 })

-- Operators / punctuation: frost tones, recede
hi('@operator',                    { fg = frost.f60 })
hi('@punctuation.bracket',         { fg = frost.f30 })
hi('@punctuation.delimiter',       { fg = frost.f30 })
hi('@punctuation.special',         { fg = ice.i10 })

-- Strings: icy cyan
hi('@string',                      { fg = aurora.cyan })
hi('@string.escape',               { fg = aurora.amber })
hi('@string.special',              { fg = aurora.amber })
hi('@string.special.url',          { fg = ice.i40,   underline = true })
hi('@string.regexp',               { fg = aurora.amber })

-- Characters / numbers / booleans
hi('@character',                   { fg = aurora.cyan })
hi('@character.special',           { fg = aurora.amber })
hi('@number',                      { fg = aurora.amber })
hi('@number.float',                { fg = aurora.amber })
hi('@boolean',                     { fg = aurora.purple })

-- Functions: ice30
hi('@function',                    { fg = ice.i30 })
hi('@function.builtin',            { fg = ice.i30,   italic = true })
hi('@function.call',               { fg = ice.i30 })
hi('@function.macro',              { fg = ice.i30 })
hi('@function.method',             { fg = ice.i30 })
hi('@function.method.call',        { fg = ice.i30 })

-- Constructor: ice50 (like types)
hi('@constructor',                 { fg = ice.i50 })

-- Variables: plain text
hi('@variable',                    { fg = frost.f10 })
hi('@variable.builtin',            { fg = ice.i10,   italic = true })  -- self, this
hi('@variable.parameter',          { fg = ice.i20 })                   -- pale ice params
hi('@variable.parameter.builtin',  { fg = ice.i20,   italic = true })
hi('@variable.member',             { fg = frost.f40 })                 -- obj fields

-- Modules / namespaces: pale ice
hi('@module',                      { fg = ice.i10 })
hi('@module.builtin',              { fg = ice.i10,   italic = true })

-- Labels
hi('@label',                       { fg = ice.i40 })

-- Types: ice50
hi('@type',                        { fg = ice.i50 })
hi('@type.builtin',                { fg = ice.i50,   italic = true })
hi('@type.definition',             { fg = ice.i50 })
hi('@type.qualifier',              { fg = ice.i40 })

-- Attributes / decorators: aurora purple (rare, should catch the eye)
hi('@attribute',                   { fg = aurora.purple })
hi('@attribute.builtin',           { fg = aurora.purple, italic = true })

-- Constants: pale ice; builtins get aurora purple
hi('@constant',                    { fg = ice.i10 })
hi('@constant.builtin',            { fg = aurora.purple })
hi('@constant.macro',              { fg = ice.i30 })

-- Markup (Markdown / RST)
hi('@markup.heading',              { fg = ice.i40,   bold = true })
hi('@markup.heading.1',            { fg = ice.i40,   bold = true })
hi('@markup.heading.2',            { fg = ice.i50,   bold = true })
hi('@markup.heading.3',            { fg = ice.i30,   bold = true })
hi('@markup.heading.4',            { fg = ice.i20,   bold = true })
hi('@markup.heading.5',            { fg = ice.i20 })
hi('@markup.heading.6',            { fg = frost.f30 })
hi('@markup.italic',               { italic = true })
hi('@markup.strong',               { bold = true })
hi('@markup.underline',            { underline = true })
hi('@markup.strikethrough',        { strikethrough = true })
hi('@markup.quote',                { fg = frost.f60, italic = true })
hi('@markup.math',                 { fg = ice.i30 })
hi('@markup.link',                 { fg = ice.i40,   underline = true })
hi('@markup.link.label',           { fg = ice.i30 })
hi('@markup.link.url',             { fg = ice.i20,   underline = true })
hi('@markup.raw',                  { fg = aurora.cyan })
hi('@markup.raw.block',            { fg = aurora.cyan })
hi('@markup.list',                 { fg = ice.i40 })
hi('@markup.list.checked',         { fg = aurora.green })
hi('@markup.list.unchecked',       { fg = frost.f60 })

-- HTML / JSX tags: blues
hi('@tag',                         { fg = ice.i40 })
hi('@tag.builtin',                 { fg = ice.i40,   italic = true })
hi('@tag.attribute',               { fg = ice.i30 })
hi('@tag.delimiter',               { fg = frost.f30 })

-- ── LSP semantic tokens ───────────────────────────────────────────────────────
hi('@lsp.type.class',              { link = '@type' })
hi('@lsp.type.decorator',          { link = '@attribute' })
hi('@lsp.type.enum',               { link = '@type' })
hi('@lsp.type.enumMember',         { link = '@constant' })
hi('@lsp.type.function',           { link = '@function' })
hi('@lsp.type.interface',          { fg = ice.i50,   italic = true })
hi('@lsp.type.macro',              { link = '@function.macro' })
hi('@lsp.type.method',             { link = '@function.method' })
hi('@lsp.type.namespace',          { link = '@module' })
hi('@lsp.type.parameter',          { link = '@variable.parameter' })
hi('@lsp.type.property',           { link = '@variable.member' })
hi('@lsp.type.struct',             { link = '@type' })
hi('@lsp.type.type',               { link = '@type' })
hi('@lsp.type.typeParameter',      { fg = ice.i20 })
hi('@lsp.type.variable',           { link = '@variable' })
hi('@lsp.type.keyword',            { link = '@keyword' })
hi('@lsp.type.comment',            { link = '@comment' })
hi('@lsp.type.string',             { link = '@string' })
hi('@lsp.type.number',             { link = '@number' })
hi('@lsp.type.operator',           { link = '@operator' })
hi('@lsp.type.selfKeyword',        { link = '@variable.builtin' })
hi('@lsp.type.builtinType',        { link = '@type.builtin' })
hi('@lsp.mod.deprecated',          { strikethrough = true })
hi('@lsp.mod.readonly',            { fg = ice.i10 })

-- ── Diagnostics ───────────────────────────────────────────────────────────────
hi('DiagnosticError',              { fg = aurora.red })
hi('DiagnosticWarn',               { fg = aurora.amber })
hi('DiagnosticInfo',               { fg = ice.i50 })
hi('DiagnosticHint',               { fg = ice.i30 })
hi('DiagnosticOk',                 { fg = aurora.green })

hi('DiagnosticUnderlineError',     { undercurl = true, sp = aurora.red })
hi('DiagnosticUnderlineWarn',      { undercurl = true, sp = aurora.amber })
hi('DiagnosticUnderlineInfo',      { undercurl = true, sp = ice.i50 })
hi('DiagnosticUnderlineHint',      { undercurl = true, sp = ice.i30 })
hi('DiagnosticUnderlineOk',        { undercurl = true, sp = aurora.green })

hi('DiagnosticVirtualTextError',   { fg = aurora.red,   bg = tint.red })
hi('DiagnosticVirtualTextWarn',    { fg = aurora.amber, bg = tint.amber })
hi('DiagnosticVirtualTextInfo',    { fg = ice.i50,      bg = tint.blue })
hi('DiagnosticVirtualTextHint',    { fg = ice.i30,      bg = tint.blue })
hi('DiagnosticVirtualTextOk',      { fg = aurora.green, bg = tint.green })

hi('DiagnosticSignError',          { fg = aurora.red })
hi('DiagnosticSignWarn',           { fg = aurora.amber })
hi('DiagnosticSignInfo',           { fg = ice.i50 })
hi('DiagnosticSignHint',           { fg = ice.i30 })

hi('DiagnosticFloatingError',      { fg = aurora.red,   bg = bg.panel })
hi('DiagnosticFloatingWarn',       { fg = aurora.amber, bg = bg.panel })
hi('DiagnosticFloatingInfo',       { fg = ice.i50,      bg = bg.panel })
hi('DiagnosticFloatingHint',       { fg = ice.i30,      bg = bg.panel })

-- ── LSP UI ────────────────────────────────────────────────────────────────────
hi('LspReferenceText',             { bg = bg.select })
hi('LspReferenceRead',             { bg = bg.select })
hi('LspReferenceWrite',            { bg = bg.select,  bold = true })
hi('LspInlayHint',                 { fg = frost.f70,  bg = bg.panel,  italic = true })
hi('LspCodeLens',                  { fg = frost.f70,  italic = true })
hi('LspCodeLensSeparator',         { fg = frost.f60 })
hi('LspSignatureActiveParameter',  { fg = aurora.amber, bold = true })

-- ── Diff ──────────────────────────────────────────────────────────────────────
hi('DiffAdd',                      { fg = aurora.green,  bg = tint.green })
hi('DiffChange',                   { fg = aurora.amber,  bg = tint.amber })
hi('DiffDelete',                   { fg = aurora.red,    bg = tint.red })
hi('DiffText',                     { fg = aurora.purple, bg = tint.purple, bold = true })

hi('Added',                        { fg = aurora.green })
hi('Changed',                      { fg = aurora.amber })
hi('Removed',                      { fg = aurora.red })
