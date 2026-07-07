# USGC-RETICLE fish theme — matched to the U.S. Graphics Company terminal
# theme (github.com/usgraphics/usgc-themes) as ported to Ghostty, and to the
# reticle.lua Neovim colorscheme.
#
# The terminal's default foreground is the phosphor green, so `normal` IS
# green — commands, params, and options inherit it. Named ANSI colors pass
# through RETICLE's palette, which remaps some slots on purpose:
#   yellow/green -> USGC amber   brblue -> USGC orange   cyan -> blue
# Hex values (no leading #) are used where the palette has no matching slot.

# Command line: green body, amber strings, recessive dim-green operators
set --global fish_color_normal normal
set --global fish_color_command normal
set --global fish_color_keyword normal
set --global fish_color_param normal
set --global fish_color_option normal
set --global fish_color_quote yellow
set --global fish_color_operator 00753d
set --global fish_color_end 00753d
set --global fish_color_redirection yellow --bold
set --global fish_color_comment brblack --italics
set --global fish_color_escape brblue
set --global fish_color_error brred
set --global fish_color_autosuggestion brblack
set --global fish_color_cancel -r
set --global fish_color_valid_path --underline

# Prompt components (USGC's own prompt colors the cwd with ANSI green,
# which RETICLE renders as amber — kept faithful here)
set --global fish_color_cwd green
set --global fish_color_cwd_root red
set --global fish_color_host normal
set --global fish_color_host_remote yellow
set --global fish_color_user normal
set --global fish_color_status red

# Selection / search: the theme's deep selection blue and amber match color
set --global fish_color_selection white --bold --background=000581
set --global fish_color_search_match black --background=yellow
set --global fish_color_history_current --bold

# Pager
set --global fish_pager_color_completion normal
set --global fish_pager_color_description brblack --italics
set --global fish_pager_color_prefix white --bold
set --global fish_pager_color_progress black --background=yellow
set --global fish_pager_color_selected_background --background=000581
