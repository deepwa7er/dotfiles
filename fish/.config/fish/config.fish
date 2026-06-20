function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end


if status is-interactive
    # Homebrew
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin

    # Add Homebrew's Ruby to PATH (specific version may vary)
    fish_add_path /opt/homebrew/Cellar/ruby/3.4.2/bin/ruby
    fish_add_path /opt/homebrew/lib/ruby/gems/3.4.0/bin

    # Set GEM_HOME and GEM_PATH to user directory
    # set -gx GEM_HOME $HOME/.gem/ruby/3.1.0
    # set -gx GEM_PATH $HOME/.gem/ruby/3.1.0

    # Add user gem binaries to PATH
    # fish_add_path $HOME/.gem/ruby/3.1.0/bin

    # Commands to run in interactive sessions can go here
    # System default
    fish_add_path /usr/bin /bin /usr/sbin /sbin /usr/local/bin


    # my stuff
    fish_add_path $HOME/build/neovim/build/bin

    # Rust
    fish_add_path $HOME/.cargo/bin

    # Go binaries
    fish_add_path $HOME/go/bin



    fish_vi_key_bindings

    alias ls "eza"
end
/Users/deepwater/.local/bin/mise activate fish | source
fish_add_path /Users/deepwater/.config/herd-lite/bin
fish_add_path /Users/deepwater/.config/composer/vendor/bin

# Start every interactive terminal inside yazi.
# Guard on YAZI_LEVEL so dropping to a shell from inside yazi doesn't relaunch it.
if status is-interactive; and not set -q YAZI_LEVEL
    y
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/deepwater/.lmstudio/bin
# End of LM Studio CLI section

# Let `tugboat fleet …` find the fleet manifest from any directory.
set -gx TUGBOAT_FLEET $HOME/code/tugboat/fleet.toml

