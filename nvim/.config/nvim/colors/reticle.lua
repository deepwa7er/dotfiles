-- reticle.lua
-- TRITIUM colorscheme for Neovim — the fleet design system (DG-002,
-- ~/code/design-guide.md) applied to syntax. USGC-RETICLE bones, BMW F30
-- night-cockpit accents.
--
-- The system: color carries a word's grammatical ROLE, typeface carries its
-- PROVENANCE. Two independent channels, per DG-002 color rules.
--
-- COLOR — role. Neutrals belong to the language (its skeleton and plumbing
-- are the same in every file); color belongs to the words you invent; warmth
-- means data.
--   steel bold  — the language's skeleton: keywords, modifiers
--   faint gray  — the language's plumbing: punctuation, operators; and the
--                 margins: comments, attributes, line numbers
--   green ink   — names for values: variables, fields, modules (dataflow)
--   data green  — data written into the source: strings, numbers, booleans
--                 (quiet blocks; the code reads, the data recedes)
--   LCD blue    — names for actions: functions, methods, macros
--   LCD ice     — names for shapes: types, traits, constructors
--   amber       — instrumentation only: warnings, search hits, changes
--   needle red  — critical only: errors, removals
--   white       — pure UI emphasis: titles, focus, current match
--
-- FACE — provenance.
--   upright     — vocabulary you invented
--   italic      — vocabulary the platform provides (self, String, true,
--                 builtin functions), and the human margins (comments)
--   bold        — the fixed skeleton of the language; UI focus
--
-- Inside dim-green data, language plumbing (escapes, interpolation braces)
-- flips to steel so the machinery stays visible. All on true black.

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'reticle'
vim.o.background = 'dark'

-- ── Palette (DG-002 TRITIUM dark tokens) ──────────────────────────────────────

local bg = {
  base    = '#000000', -- true black, not near-black
  surface = '#0a0a0a', -- cursorline, folds
  panel   = '#101010', -- floats, statusline, pmenu
  select  = '#000581', -- selection blue (terminal selection-background)
}

local rule = {
  base   = '#242424', -- hairlines: window separators
  strong = '#3d3d3b', -- strong rules: float borders, scrollbar thumb
}

local ink = {
  base  = '#00a645', -- phosphor green — body text
  data  = '#008d41', -- data green — literals: strings, numbers, booleans
  muted = '#00753d', -- dim green — secondary UI, markup furniture
  faint = '#4a4a48', -- gray — punctuation, operators, comments, tertiary
}

local accent   = '#4a90d4' -- LCD blue — functions, links, info
local steel    = '#858e97' -- instrument gray (terminal cursor-color) — keywords
local amber    = '#ffbf00' -- warnings, search, diff-change — instrumentation only
local crit     = '#e0281e' -- needle red — errors only
local emphasis = '#ffffff' -- white — types, titles, focus

-- LCD data island (cool inset, from the F30 cluster)
local lcd = {
  bg  = '#101720',
  ink = '#cfe0f2',
}

-- Tinted backgrounds for virtual text / diff
local tint = {
  red   = '#2a0000',
  amber = '#2a2000',
  green = '#002a12',
  blue  = '#000a2a',
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor UI ─────────────────────────────────────────────────────────────────
hi('Normal',          { fg = ink.base,   bg = bg.base })
hi('NormalFloat',     { fg = ink.base,   bg = bg.panel })
hi('FloatBorder',     { fg = rule.strong, bg = bg.panel })
hi('FloatTitle',      { fg = emphasis,   bg = bg.panel,  bold = true })

hi('Cursor',          { fg = emphasis,   bg = steel })
hi('CursorLine',      { bg = bg.surface })
hi('CursorColumn',    { bg = bg.surface })
hi('CursorLineNr',    { fg = emphasis,   bg = bg.surface, bold = true })
hi('LineNr',          { fg = ink.faint })
hi('LineNrAbove',     { fg = ink.faint })
hi('LineNrBelow',     { fg = ink.faint })

hi('SignColumn',      { fg = ink.muted,  bg = bg.base })
hi('FoldColumn',      { fg = ink.muted,  bg = bg.base })
hi('ColorColumn',     { bg = bg.surface })

hi('StatusLine',      { fg = ink.base,   bg = bg.panel })
hi('StatusLineNC',    { fg = ink.muted,  bg = bg.panel })
hi('TabLine',         { fg = ink.muted,  bg = bg.panel })
hi('TabLineSel',      { fg = emphasis,   bg = bg.base,   bold = true })
hi('TabLineFill',     { bg = bg.panel })

hi('WinSeparator',    { fg = rule.base })
hi('VertSplit',       { fg = rule.base })

hi('Pmenu',           { fg = ink.base,   bg = bg.panel })
hi('PmenuSel',        { fg = lcd.ink,    bg = lcd.bg,    bold = true })
hi('PmenuSbar',       { bg = bg.panel })
hi('PmenuThumb',      { bg = rule.strong })
hi('PmenuKind',       { fg = accent,     bg = bg.panel })
hi('PmenuKindSel',    { fg = accent,     bg = lcd.bg })
hi('PmenuExtra',      { fg = ink.muted,  bg = bg.panel })
hi('PmenuExtraSel',   { fg = ink.muted,  bg = lcd.bg })

-- Visual: the deep selection blue from the terminal theme
hi('Visual',          { bg = bg.select })
hi('VisualNOS',       { bg = bg.select })

-- Search: black on amber (instrumentation); current match black on white
hi('Search',          { fg = bg.base,    bg = amber })
hi('IncSearch',       { fg = bg.base,    bg = emphasis,  bold = true })
hi('CurSearch',       { fg = bg.base,    bg = emphasis,  bold = true })
hi('Substitute',      { fg = emphasis,   bg = crit })

hi('MatchParen',      { fg = emphasis,   bg = rule.base, bold = true })

hi('NonText',         { fg = rule.base })
hi('Whitespace',      { fg = rule.base })
hi('EndOfBuffer',     { fg = bg.panel })
hi('SpecialKey',      { fg = ink.muted })
hi('Conceal',         { fg = ink.muted })

hi('Folded',          { fg = ink.muted,  bg = bg.surface })

hi('Directory',       { fg = accent,     bold = true })
hi('Title',           { fg = emphasis,   bold = true })
hi('Question',        { fg = ink.base })
hi('MoreMsg',         { fg = ink.base })
hi('ModeMsg',         { fg = ink.base })
hi('ErrorMsg',        { fg = crit })
hi('WarningMsg',      { fg = amber })

hi('SpellBad',        { undercurl = true, sp = crit })
hi('SpellCap',        { undercurl = true, sp = amber })
hi('SpellRare',       { undercurl = true, sp = accent })
hi('SpellLocal',      { undercurl = true, sp = ink.muted })

hi('QuickFixLine',    { bg = bg.select })
hi('WildMenu',        { fg = lcd.ink,    bg = lcd.bg })

-- ── Syntax ────────────────────────────────────────────────────────────────────

-- Comments: faint gray, the margins of the page
hi('Comment',         { fg = ink.faint,  italic = true })

-- Identifiers / variables: green ink
hi('Identifier',      { fg = ink.base })

-- Strings: data green — quiet data blocks
hi('String',          { fg = ink.data })
hi('Character',       { fg = ink.data })

-- Numbers / booleans: data green (true/false are the platform's
-- words, so italic)
hi('Number',          { fg = ink.data })
hi('Float',           { fg = ink.data })
hi('Boolean',         { fg = ink.data,   italic = true })

-- Constants: green ink
hi('Constant',        { fg = ink.base })

-- Functions: LCD blue — the names you invoke
hi('Function',        { fg = accent })

-- Keywords / control flow: bold steel — structure, a hue apart from the body
hi('Statement',       { fg = steel,      bold = true })
hi('Conditional',     { fg = steel,      bold = true })
hi('Repeat',          { fg = steel,      bold = true })
hi('Label',           { fg = steel,      bold = true })
hi('Keyword',         { fg = steel,      bold = true })
hi('Exception',       { fg = steel,      bold = true })

-- Operators: faint gray, recede — a hue apart from the green body
hi('Operator',        { fg = ink.faint })

-- Preprocessor: bold steel like keywords; macros are callables, so blue
hi('PreProc',         { fg = steel,      bold = true })
hi('Include',         { fg = steel,      bold = true })
hi('Define',          { fg = steel,      bold = true })
hi('Macro',           { fg = accent })
hi('PreCondit',       { fg = steel,      bold = true })

-- Types: LCD ice. Classic syntax mostly highlights builtin types (int, char),
-- so the legacy group keeps the platform italic.
hi('Type',            { fg = lcd.ink,    italic = true })
hi('StorageClass',    { fg = steel,      bold = true })
hi('Structure',       { fg = steel,      bold = true })
hi('Typedef',         { fg = steel,      bold = true })

-- Delimiters / punctuation: faint gray
hi('Delimiter',       { fg = ink.faint })
hi('Special',         { fg = ink.base })
hi('SpecialChar',     { fg = steel })
hi('Tag',             { fg = ink.base })
hi('SpecialComment',  { fg = ink.faint,  italic = true, bold = true })
hi('Debug',           { fg = crit })

hi('Underlined',      { underline = true })
hi('Ignore',          { fg = ink.muted })
hi('Error',           { fg = crit })
hi('Todo',            { fg = bg.base,    bg = amber, bold = true })

-- ── Treesitter ────────────────────────────────────────────────────────────────

-- Comments
hi('@comment',                     { fg = ink.faint,    italic = true })
hi('@comment.documentation',       { fg = ink.faint,    italic = true })
hi('@comment.error',               { fg = crit,         bold = true, italic = true })
hi('@comment.warning',             { fg = amber,        bold = true, italic = true })
hi('@comment.todo',                { fg = bg.base,      bg = amber, bold = true })
hi('@comment.note',                { fg = accent,       bold = true, italic = true })

-- Keywords: bold steel
hi('@keyword',                     { fg = steel,        bold = true })
hi('@keyword.function',            { fg = steel,        bold = true })
hi('@keyword.operator',            { fg = steel,        bold = true })
hi('@keyword.return',              { fg = steel,        bold = true })
hi('@keyword.import',              { fg = steel,        bold = true })
hi('@keyword.modifier',            { fg = steel,        bold = true })
hi('@keyword.repeat',              { fg = steel,        bold = true })
hi('@keyword.exception',           { fg = steel,        bold = true })
hi('@keyword.conditional',         { fg = steel,        bold = true })
hi('@keyword.conditional.ternary', { fg = ink.faint })
hi('@keyword.directive',           { fg = steel,        bold = true })
hi('@keyword.directive.define',    { fg = steel,        bold = true })

-- Operators / punctuation: faint gray, recede — a hue apart from the body
hi('@operator',                    { fg = ink.faint })
hi('@punctuation.bracket',         { fg = ink.faint })
hi('@punctuation.delimiter',       { fg = ink.faint })
hi('@punctuation.special',         { fg = steel })  -- interpolation braces: plumbing inside data

-- Strings: data green; escapes and format specifiers are language
-- plumbing inside the data, so steel. URLs are links — blue, interactive.
hi('@string',                      { fg = ink.data })
hi('@string.escape',               { fg = steel })
hi('@string.special',              { fg = steel })
hi('@string.special.url',          { fg = accent,       underline = true })
hi('@string.regexp',               { fg = ink.data })

-- Characters / numbers / booleans: data-green literals; platform words italic
hi('@character',                   { fg = ink.data })
hi('@character.special',           { fg = steel })
hi('@number',                      { fg = ink.data })
hi('@number.float',                { fg = ink.data })
hi('@boolean',                     { fg = ink.data,     italic = true })

-- Functions: LCD blue; builtins are the platform's, so italic. Macros are
-- upright — the ! sigil already marks them, and most are yours to name.
hi('@function',                    { fg = accent })
hi('@function.builtin',            { fg = accent,       italic = true })
hi('@function.call',               { fg = accent })
hi('@function.macro',              { fg = accent })
hi('@function.method',             { fg = accent })
hi('@function.method.call',        { fg = accent })

-- Constructor: LCD ice, upright — a shape you defined
hi('@constructor',                 { fg = lcd.ink })

-- Variables: green ink body
hi('@variable',                    { fg = ink.base })
hi('@variable.builtin',            { fg = ink.base,     italic = true })  -- self, this
hi('@variable.parameter',          { fg = ink.base })
hi('@variable.parameter.builtin',  { fg = ink.base,     italic = true })
hi('@variable.member',             { fg = ink.base })

-- Modules / namespaces: green ink
hi('@module',                      { fg = ink.base })
hi('@module.builtin',              { fg = ink.base,     italic = true })

-- Labels
hi('@label',                       { fg = steel,        bold = true })

-- Types: LCD ice — your shapes upright, the platform's (String, i32) italic
hi('@type',                        { fg = lcd.ink })
hi('@type.builtin',                { fg = lcd.ink,      italic = true })
hi('@type.definition',             { fg = lcd.ink })
hi('@type.qualifier',              { fg = steel,        bold = true })

-- Attributes / decorators: faint italic — metadata, not code
hi('@attribute',                   { fg = ink.faint,    italic = true })
hi('@attribute.builtin',           { fg = ink.faint,    italic = true })

-- Constants: green ink names; builtins (nil, None) are the platform's
-- literals — data green italic
hi('@constant',                    { fg = ink.base })
hi('@constant.builtin',            { fg = ink.data,     italic = true })
hi('@constant.macro',              { fg = ink.base })

-- Markup (Markdown / RST)
hi('@markup.heading',              { fg = emphasis,     bold = true })
hi('@markup.heading.1',            { fg = emphasis,     bold = true })
hi('@markup.heading.2',            { fg = emphasis,     bold = true })
hi('@markup.heading.3',            { fg = ink.base,     bold = true })
hi('@markup.heading.4',            { fg = ink.base,     bold = true })
hi('@markup.heading.5',            { fg = ink.base })
hi('@markup.heading.6',            { fg = ink.muted })
hi('@markup.italic',               { italic = true })
hi('@markup.strong',               { bold = true })
hi('@markup.underline',            { underline = true })
hi('@markup.strikethrough',        { strikethrough = true })
hi('@markup.quote',                { fg = ink.faint,    italic = true })
hi('@markup.math',                 { fg = ink.base })
hi('@markup.link',                 { fg = accent,       underline = true })
hi('@markup.link.label',           { fg = accent })
hi('@markup.link.url',             { fg = accent,       underline = true })
hi('@markup.raw',                  { fg = ink.data })
hi('@markup.raw.block',            { fg = ink.data })
hi('@markup.list',                 { fg = ink.muted })
hi('@markup.list.checked',         { fg = ink.base })
hi('@markup.list.unchecked',       { fg = ink.muted })

-- HTML / JSX tags: bold ink structure, plain ink attributes
hi('@tag',                         { fg = ink.base,     bold = true })
hi('@tag.builtin',                 { fg = ink.base,     bold = true })
hi('@tag.attribute',               { fg = ink.base })
hi('@tag.delimiter',               { fg = ink.faint })

-- ── LSP semantic tokens ───────────────────────────────────────────────────────
hi('@lsp.type.class',              { link = '@type' })
hi('@lsp.type.decorator',          { link = '@attribute' })
hi('@lsp.type.enum',               { link = '@type' })
hi('@lsp.type.enumMember',         { link = '@constant' })
hi('@lsp.type.function',           { link = '@function' })
hi('@lsp.type.interface',          { fg = lcd.ink })
hi('@lsp.type.macro',              { link = '@function.macro' })
hi('@lsp.type.method',             { link = '@function.method' })
hi('@lsp.type.namespace',          { link = '@module' })
hi('@lsp.type.parameter',          { link = '@variable.parameter' })
hi('@lsp.type.property',           { link = '@variable.member' })
hi('@lsp.type.struct',             { link = '@type' })
hi('@lsp.type.type',               { link = '@type' })
hi('@lsp.type.typeParameter',      { fg = lcd.ink })
hi('@lsp.type.variable',           { link = '@variable' })
hi('@lsp.type.keyword',            { link = '@keyword' })
hi('@lsp.type.comment',            { link = '@comment' })
hi('@lsp.type.string',             { link = '@string' })
hi('@lsp.type.number',             { link = '@number' })
hi('@lsp.type.operator',           { link = '@operator' })
hi('@lsp.type.selfKeyword',        { link = '@variable.builtin' })
hi('@lsp.type.builtinType',        { link = '@type.builtin' })
hi('@lsp.mod.deprecated',          { strikethrough = true })
hi('@lsp.mod.readonly',            { fg = ink.base })

-- ── Diagnostics ───────────────────────────────────────────────────────────────
hi('DiagnosticError',              { fg = crit })
hi('DiagnosticWarn',               { fg = amber })
hi('DiagnosticInfo',               { fg = accent })
hi('DiagnosticHint',               { fg = ink.faint })
hi('DiagnosticOk',                 { fg = ink.base })

hi('DiagnosticUnderlineError',     { undercurl = true, sp = crit })
hi('DiagnosticUnderlineWarn',      { undercurl = true, sp = amber })
hi('DiagnosticUnderlineInfo',      { undercurl = true, sp = accent })
hi('DiagnosticUnderlineHint',      { undercurl = true, sp = ink.faint })
hi('DiagnosticUnderlineOk',        { undercurl = true, sp = ink.base })

hi('DiagnosticVirtualTextError',   { fg = crit,         bg = tint.red })
hi('DiagnosticVirtualTextWarn',    { fg = amber,        bg = tint.amber })
hi('DiagnosticVirtualTextInfo',    { fg = accent,       bg = tint.blue })
hi('DiagnosticVirtualTextHint',    { fg = ink.faint,    bg = bg.panel })
hi('DiagnosticVirtualTextOk',      { fg = ink.base,     bg = tint.green })

hi('DiagnosticSignError',          { fg = crit })
hi('DiagnosticSignWarn',           { fg = amber })
hi('DiagnosticSignInfo',           { fg = accent })
hi('DiagnosticSignHint',           { fg = ink.faint })

hi('DiagnosticFloatingError',      { fg = crit,         bg = bg.panel })
hi('DiagnosticFloatingWarn',       { fg = amber,        bg = bg.panel })
hi('DiagnosticFloatingInfo',       { fg = accent,       bg = bg.panel })
hi('DiagnosticFloatingHint',       { fg = ink.faint,    bg = bg.panel })

-- ── LSP UI ────────────────────────────────────────────────────────────────────
hi('LspReferenceText',             { bg = '#161616' })
hi('LspReferenceRead',             { bg = '#161616' })
hi('LspReferenceWrite',            { bg = '#161616',    bold = true })
hi('LspInlayHint',                 { fg = ink.faint,    bg = bg.surface, italic = true })
hi('LspCodeLens',                  { fg = ink.faint,    italic = true })
hi('LspCodeLensSeparator',         { fg = ink.muted })
hi('LspSignatureActiveParameter',  { fg = emphasis,     bold = true })

-- ── Diff ──────────────────────────────────────────────────────────────────────
hi('DiffAdd',                      { fg = ink.base,     bg = tint.green })
hi('DiffChange',                   { fg = amber,        bg = tint.amber })
hi('DiffDelete',                   { fg = crit,         bg = tint.red })
hi('DiffText',                     { fg = emphasis,     bg = tint.amber, bold = true })

hi('Added',                        { fg = ink.base })
hi('Changed',                      { fg = amber })
hi('Removed',                      { fg = crit })
