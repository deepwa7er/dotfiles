-- reticle.lua
-- USGC-RETICLE colorscheme for Neovim, matched to the U.S. Graphics Company
-- terminal/Sublime themes (github.com/usgraphics/usgc-themes, part no. 5200-020).
--
-- Philosophy: a single phosphor green for all code — variables, keywords,
-- types, and functions alike (italics carry the type distinction) — on pure
-- black, amber as the warm second voice (strings, warnings), white reserved
-- for UI emphasis, fluorescent pink/orange/blue/violet as rare accents.
-- Red gutter numbers are from USGC's own Sublime spec.

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'reticle'
vim.o.background = 'dark'

-- ── Palette ───────────────────────────────────────────────────────────────────

-- Backgrounds: pure black, hairline grays for surfaces
local bg = {
  base   = '#000000', -- editor background
  panel  = '#0e0e0e', -- panels, floats, statusline
  select = '#000581', -- selection blue (from the iTerm selection color)
  fill   = '#262626', -- subtle fills (ANSI 0)
}

-- Phosphor green (USGC green), plus a dim step for recessive marks
local green = {
  dim  = '#00753d', -- operators, punctuation, muted UI
  base = '#00a645', -- body text, keywords, types, functions
}

-- Warm voice
local amber  = '#ffbf00' -- strings, warnings (USGC amber)
local yellow = '#ffff00' -- search only (USGC fl_yellow)

-- Fluorescent accents (rare pops)
local accent = {
  red    = '#e00000', -- errors
  pink   = '#ff208f', -- numbers
  orange = '#ff7321', -- booleans, builtin constants, escapes
  blue   = '#0079ff', -- links, info, directories
  violet = '#723df9', -- attributes, decorators
}

local white  = '#ffffff' -- keywords, types, emphasis
local maroon = '#a00000' -- line numbers (USGC spec uses a red gutter)
local gray   = '#666666' -- comments (derived neutral; recedes behind green)

-- Tinted backgrounds for virtual text / diff
local tint = {
  red   = '#2a0000',
  amber = '#2a2000',
  green = '#002a12',
  blue  = '#000a2a',
  pink  = '#2a0018',
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor UI ─────────────────────────────────────────────────────────────────
hi('Normal',          { fg = green.base, bg = bg.base })
hi('NormalFloat',     { fg = green.base, bg = bg.panel })
hi('FloatBorder',     { fg = green.dim,  bg = bg.panel })
hi('FloatTitle',      { fg = white,      bg = bg.panel,  bold = true })

hi('Cursor',          { fg = bg.base,    bg = white })
hi('CursorLine',      { bg = bg.panel })
hi('CursorColumn',    { bg = bg.panel })
hi('CursorLineNr',    { fg = white,      bg = bg.panel,  bold = true })
hi('LineNr',          { fg = maroon })
hi('LineNrAbove',     { fg = maroon })
hi('LineNrBelow',     { fg = maroon })

hi('SignColumn',      { fg = green.dim,  bg = bg.base })
hi('FoldColumn',      { fg = green.dim,  bg = bg.base })
hi('ColorColumn',     { bg = bg.panel })

hi('StatusLine',      { fg = green.base, bg = bg.panel })
hi('StatusLineNC',    { fg = green.dim,  bg = bg.panel })
hi('TabLine',         { fg = green.dim,  bg = bg.panel })
hi('TabLineSel',      { fg = white,      bg = bg.base,   bold = true })
hi('TabLineFill',     { bg = bg.panel })

hi('WinSeparator',    { fg = bg.fill })
hi('VertSplit',       { fg = bg.fill })

hi('Pmenu',           { fg = green.base, bg = bg.panel })
hi('PmenuSel',        { fg = white,      bg = bg.select })
hi('PmenuSbar',       { bg = bg.panel })
hi('PmenuThumb',      { bg = bg.fill })
hi('PmenuKind',       { fg = amber,      bg = bg.panel })
hi('PmenuKindSel',    { fg = amber,      bg = bg.select })
hi('PmenuExtra',      { fg = green.dim,  bg = bg.panel })
hi('PmenuExtraSel',   { fg = green.dim,  bg = bg.select })

-- Visual: the deep selection blue from the terminal theme
hi('Visual',          { bg = bg.select })
hi('VisualNOS',       { bg = bg.select })

-- Search: fluorescent yellow — matches iTerm's match-highlight color
hi('Search',          { fg = bg.base,    bg = yellow })
hi('IncSearch',       { fg = bg.base,    bg = accent.orange, bold = true })
hi('CurSearch',       { fg = bg.base,    bg = accent.orange, bold = true })
hi('Substitute',      { fg = white,      bg = accent.red })

hi('MatchParen',      { fg = white,      bg = bg.fill,   bold = true })

hi('NonText',         { fg = bg.fill })
hi('Whitespace',      { fg = bg.fill })
hi('EndOfBuffer',     { fg = bg.panel })
hi('SpecialKey',      { fg = green.dim })
hi('Conceal',         { fg = green.dim })

hi('Folded',          { fg = green.dim,  bg = bg.panel })

hi('Directory',       { fg = accent.blue, bold = true })
hi('Title',           { fg = white,       bold = true })
hi('Question',        { fg = green.base })
hi('MoreMsg',         { fg = green.base })
hi('ModeMsg',         { fg = green.base })
hi('ErrorMsg',        { fg = accent.red })
hi('WarningMsg',      { fg = amber })

hi('SpellBad',        { undercurl = true, sp = accent.red })
hi('SpellCap',        { undercurl = true, sp = amber })
hi('SpellRare',       { undercurl = true, sp = accent.violet })
hi('SpellLocal',      { undercurl = true, sp = accent.blue })

hi('QuickFixLine',    { bg = bg.select })
hi('WildMenu',        { fg = white,      bg = bg.select })

-- ── Syntax ────────────────────────────────────────────────────────────────────

-- Comments: neutral gray, recede behind the green body
hi('Comment',         { fg = gray,        italic = true })

-- Identifiers: phosphor green body
hi('Identifier',      { fg = green.base })

-- Strings: amber — the USGC green/amber two-tone
hi('String',          { fg = amber })
hi('Character',       { fg = amber })

-- Numbers: fluorescent pink
hi('Number',          { fg = accent.pink })
hi('Float',           { fg = accent.pink })

-- Booleans / nil / null: fluorescent orange
hi('Boolean',         { fg = accent.orange })

-- Constants: phosphor green
hi('Constant',        { fg = green.base })

-- Functions: phosphor green, same as the body
hi('Function',        { fg = green.base })

-- Keywords / control flow: phosphor green, same as the body
hi('Statement',       { fg = green.base })
hi('Conditional',     { fg = green.base })
hi('Repeat',          { fg = green.base })
hi('Label',           { fg = green.base })
hi('Keyword',         { fg = green.base })
hi('Exception',       { fg = green.base })

-- Operators: dim green — recede into background
hi('Operator',        { fg = green.dim })

-- Preprocessor / macros: phosphor green italic
hi('PreProc',         { fg = green.base,  italic = true })
hi('Include',         { fg = green.base })
hi('Define',          { fg = green.base,  italic = true })
hi('Macro',           { fg = green.base,  italic = true })
hi('PreCondit',       { fg = green.base,  italic = true })

-- Types: phosphor green italic
hi('Type',            { fg = green.base,  italic = true })
hi('StorageClass',    { fg = green.base })
hi('Structure',       { fg = green.base,  italic = true })
hi('Typedef',         { fg = green.base,  italic = true })

-- Delimiters / punctuation: dim green
hi('Delimiter',       { fg = green.dim })
hi('Special',         { fg = green.base })
hi('SpecialChar',     { fg = accent.orange })
hi('Tag',             { fg = green.base })
hi('SpecialComment',  { fg = gray,        italic = true, bold = true })
hi('Debug',           { fg = accent.red })

hi('Underlined',      { underline = true })
hi('Ignore',          { fg = green.dim })
hi('Error',           { fg = accent.red })
hi('Todo',            { fg = bg.base,     bg = amber, bold = true })

-- ── Treesitter ────────────────────────────────────────────────────────────────

-- Comments
hi('@comment',                     { fg = gray,         italic = true })
hi('@comment.documentation',       { fg = gray,         italic = true })
hi('@comment.error',               { fg = accent.red,   bold = true, italic = true })
hi('@comment.warning',             { fg = amber,        bold = true, italic = true })
hi('@comment.todo',                { fg = bg.base,      bg = amber, bold = true })
hi('@comment.note',                { fg = accent.blue,  bold = true, italic = true })

-- Keywords: phosphor green, same as the body
hi('@keyword',                     { fg = green.base })
hi('@keyword.function',            { fg = green.base })
hi('@keyword.operator',            { fg = green.base })
hi('@keyword.return',              { fg = green.base })
hi('@keyword.import',              { fg = green.base })
hi('@keyword.modifier',            { fg = green.base })
hi('@keyword.repeat',              { fg = green.base })
hi('@keyword.exception',           { fg = green.base })
hi('@keyword.conditional',         { fg = green.base })
hi('@keyword.conditional.ternary', { fg = green.base })
hi('@keyword.directive',           { fg = green.base,   italic = true })
hi('@keyword.directive.define',    { fg = green.base,   italic = true })

-- Operators / punctuation: dim green, recede
hi('@operator',                    { fg = green.dim })
hi('@punctuation.bracket',         { fg = green.dim })
hi('@punctuation.delimiter',       { fg = green.dim })
hi('@punctuation.special',         { fg = green.base })

-- Strings: amber
hi('@string',                      { fg = amber })
hi('@string.escape',               { fg = accent.orange })
hi('@string.special',              { fg = accent.orange })
hi('@string.special.url',          { fg = accent.blue,  underline = true })
hi('@string.regexp',               { fg = accent.orange })

-- Characters / numbers / booleans
hi('@character',                   { fg = amber })
hi('@character.special',           { fg = accent.orange })
hi('@number',                      { fg = accent.pink })
hi('@number.float',                { fg = accent.pink })
hi('@boolean',                     { fg = accent.orange })

-- Functions: phosphor green, same as the body
hi('@function',                    { fg = green.base })
hi('@function.builtin',            { fg = green.base,   italic = true })
hi('@function.call',               { fg = green.base })
hi('@function.macro',              { fg = green.base,   italic = true })
hi('@function.method',             { fg = green.base })
hi('@function.method.call',        { fg = green.base })

-- Constructor: phosphor green italic (like types)
hi('@constructor',                 { fg = green.base,   italic = true })

-- Variables: phosphor green body
hi('@variable',                    { fg = green.base })
hi('@variable.builtin',            { fg = green.base,   italic = true })  -- self, this
hi('@variable.parameter',          { fg = green.base })
hi('@variable.parameter.builtin',  { fg = green.base,   italic = true })
hi('@variable.member',             { fg = green.base })

-- Modules / namespaces: green body
hi('@module',                      { fg = green.base })
hi('@module.builtin',              { fg = green.base,   italic = true })

-- Labels
hi('@label',                       { fg = green.base })

-- Types: phosphor green italic
hi('@type',                        { fg = green.base,   italic = true })
hi('@type.builtin',                { fg = green.base,   italic = true })
hi('@type.definition',             { fg = green.base,   italic = true })
hi('@type.qualifier',              { fg = green.base })

-- Attributes / decorators: fluorescent violet (rare, should catch the eye)
hi('@attribute',                   { fg = accent.violet })
hi('@attribute.builtin',           { fg = accent.violet, italic = true })

-- Constants: phosphor green; builtins get fluorescent orange
hi('@constant',                    { fg = green.base })
hi('@constant.builtin',            { fg = accent.orange })
hi('@constant.macro',              { fg = green.base,   italic = true })

-- Markup (Markdown / RST)
hi('@markup.heading',              { fg = green.base,   bold = true })
hi('@markup.heading.1',            { fg = green.base,   bold = true })
hi('@markup.heading.2',            { fg = amber,        bold = true })
hi('@markup.heading.3',            { fg = green.base,   bold = true })
hi('@markup.heading.4',            { fg = green.base,   bold = true })
hi('@markup.heading.5',            { fg = green.base })
hi('@markup.heading.6',            { fg = green.dim })
hi('@markup.italic',               { italic = true })
hi('@markup.strong',               { bold = true })
hi('@markup.underline',            { underline = true })
hi('@markup.strikethrough',        { strikethrough = true })
hi('@markup.quote',                { fg = gray,         italic = true })
hi('@markup.math',                 { fg = green.base })
hi('@markup.link',                 { fg = accent.blue,  underline = true })
hi('@markup.link.label',           { fg = accent.blue })
hi('@markup.link.url',             { fg = accent.blue,  underline = true })
hi('@markup.raw',                  { fg = amber })
hi('@markup.raw.block',            { fg = amber })
hi('@markup.list',                 { fg = green.base })
hi('@markup.list.checked',         { fg = green.base })
hi('@markup.list.unchecked',       { fg = green.dim })

-- HTML / JSX tags
hi('@tag',                         { fg = green.base })
hi('@tag.builtin',                 { fg = green.base,   italic = true })
hi('@tag.attribute',               { fg = green.base })
hi('@tag.delimiter',               { fg = green.dim })

-- ── LSP semantic tokens ───────────────────────────────────────────────────────
hi('@lsp.type.class',              { link = '@type' })
hi('@lsp.type.decorator',          { link = '@attribute' })
hi('@lsp.type.enum',               { link = '@type' })
hi('@lsp.type.enumMember',         { link = '@constant' })
hi('@lsp.type.function',           { link = '@function' })
hi('@lsp.type.interface',          { fg = green.base,   italic = true })
hi('@lsp.type.macro',              { link = '@function.macro' })
hi('@lsp.type.method',             { link = '@function.method' })
hi('@lsp.type.namespace',          { link = '@module' })
hi('@lsp.type.parameter',          { link = '@variable.parameter' })
hi('@lsp.type.property',           { link = '@variable.member' })
hi('@lsp.type.struct',             { link = '@type' })
hi('@lsp.type.type',               { link = '@type' })
hi('@lsp.type.typeParameter',      { fg = green.base,   italic = true })
hi('@lsp.type.variable',           { link = '@variable' })
hi('@lsp.type.keyword',            { link = '@keyword' })
hi('@lsp.type.comment',            { link = '@comment' })
hi('@lsp.type.string',             { link = '@string' })
hi('@lsp.type.number',             { link = '@number' })
hi('@lsp.type.operator',           { link = '@operator' })
hi('@lsp.type.selfKeyword',        { link = '@variable.builtin' })
hi('@lsp.type.builtinType',        { link = '@type.builtin' })
hi('@lsp.mod.deprecated',          { strikethrough = true })
hi('@lsp.mod.readonly',            { fg = green.base })

-- ── Diagnostics ───────────────────────────────────────────────────────────────
hi('DiagnosticError',              { fg = accent.red })
hi('DiagnosticWarn',               { fg = amber })
hi('DiagnosticInfo',               { fg = accent.blue })
hi('DiagnosticHint',               { fg = gray })
hi('DiagnosticOk',                 { fg = green.base })

hi('DiagnosticUnderlineError',     { undercurl = true, sp = accent.red })
hi('DiagnosticUnderlineWarn',      { undercurl = true, sp = amber })
hi('DiagnosticUnderlineInfo',      { undercurl = true, sp = accent.blue })
hi('DiagnosticUnderlineHint',      { undercurl = true, sp = gray })
hi('DiagnosticUnderlineOk',        { undercurl = true, sp = green.base })

hi('DiagnosticVirtualTextError',   { fg = accent.red,   bg = tint.red })
hi('DiagnosticVirtualTextWarn',    { fg = amber,        bg = tint.amber })
hi('DiagnosticVirtualTextInfo',    { fg = accent.blue,  bg = tint.blue })
hi('DiagnosticVirtualTextHint',    { fg = gray,         bg = bg.panel })
hi('DiagnosticVirtualTextOk',      { fg = green.base,   bg = tint.green })

hi('DiagnosticSignError',          { fg = accent.red })
hi('DiagnosticSignWarn',           { fg = amber })
hi('DiagnosticSignInfo',           { fg = accent.blue })
hi('DiagnosticSignHint',           { fg = gray })

hi('DiagnosticFloatingError',      { fg = accent.red,   bg = bg.panel })
hi('DiagnosticFloatingWarn',       { fg = amber,        bg = bg.panel })
hi('DiagnosticFloatingInfo',       { fg = accent.blue,  bg = bg.panel })
hi('DiagnosticFloatingHint',       { fg = gray,         bg = bg.panel })

-- ── LSP UI ────────────────────────────────────────────────────────────────────
hi('LspReferenceText',             { bg = bg.fill })
hi('LspReferenceRead',             { bg = bg.fill })
hi('LspReferenceWrite',            { bg = bg.fill,      bold = true })
hi('LspInlayHint',                 { fg = gray,         bg = bg.panel, italic = true })
hi('LspCodeLens',                  { fg = gray,         italic = true })
hi('LspCodeLensSeparator',         { fg = green.dim })
hi('LspSignatureActiveParameter',  { fg = amber,        bold = true })

-- ── Diff ──────────────────────────────────────────────────────────────────────
hi('DiffAdd',                      { fg = green.base,   bg = tint.green })
hi('DiffChange',                   { fg = amber,        bg = tint.amber })
hi('DiffDelete',                   { fg = accent.red,   bg = tint.red })
hi('DiffText',                     { fg = accent.pink,  bg = tint.pink, bold = true })

hi('Added',                        { fg = green.base })
hi('Changed',                      { fg = amber })
hi('Removed',                      { fg = accent.red })
