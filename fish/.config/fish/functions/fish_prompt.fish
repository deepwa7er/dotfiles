function fish_prompt
    set -l last_status $status

    set -l stat
    if test $last_status -ne 0
	set stat (set_color red)"[$last_status]"(set_color normal)
    end
    set -l git_status (fish_git_prompt)
    # USGC-RETICLE prompt colors: white host, phosphor-green cwd, dim-green
    # git status, red accent — after USGC's own reference prompt.
    echo (set_color white)deepwater (set_color normal)(prompt_pwd) (set_color 00753d)$git_status $stat (set_color red)󰬯 (set_color normal)
end
