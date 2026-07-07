# USGC-RETICLE vi-mode indicator. Replaces fish_default_mode_prompt, whose
# bold-green [I] renders amber under the RETICLE palette and shouted over the
# prompt. Insert is the resting state, so it sits in the dim phosphor green;
# the other modes get the theme's accents.
function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo '[N]'
        case insert
            set_color 00753d
            echo '[I]'
        case replace_one replace
            set_color --bold cyan
            echo '[R]'
        case visual
            set_color --bold magenta
            echo '[V]'
    end
    set_color normal
    echo ' '
end
