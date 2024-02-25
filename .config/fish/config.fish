set -g fish_greeting ""

# homebrew
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
fish_add_path -gP "/opt/homebrew/bin" "/opt/homebrew/sbin";
! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim

# golang
set GOBIN $HOME/go/bin
fish_add_path $GOBIN

# ruby
fish_add_path /opt/homebrew/opt/ruby/bin

# rust & cargo
fish_add_path $HOME/.cargo/bin/

function verda_stg --description 'access VKS staging'
	source $HOME/dev/verda_data_staging-tokyo-fish.sh
	vksctl use dap-vks-staging
	kubectl config use-context dap-vks-staging-tokyo
end

function verda_prod --description 'access VKS production'
	source $HOME/dev/verda_data_staging-tokyo-fish.sh
	vksctl use dap-vks-release
	kubectl config use-context dap-release-tokyo
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

set -gx CONFIG_DIR ~/.config
set -gx DOTFILES_DIR ~/dev/dotfiles
set -gx DOTFILES_CONFIG_DIR ~/dev/dotfiles-config

alias v="nvim"
alias vv="sudo v"
alias python3="python"
alias lg="lazygit"
alias f="yazi"
alias cat="bat"
alias df="duf"
alias du="dust"
alias bm="hyperfine"

alias bi="brew install"
alias bu="brew upgrade --fetch-HEAD"

alias cdc="cd $CONFIG_DIR"
alias cddf="cd $DOTFILES_DIR"
alias cddc="cd $DOTFILES_CONFIG_DIR"
alias cdv="cd $DOTFILES_CONFIG_DIR/nvim"
alias cfv="cdv & v"
alias cfvkm="cdv & v $DOTFILES_CONFIG_DIR/.config/nvim/lua/config/keymaps.lua"
alias cff="v $DOTFILES_DIR/.config/fish/config.fish"
alias ref="source $DOTFILES_DIR/.config/fish/config.fish"
alias cfyz="v $DOTFILES_DIR/.config/yazi/yazi.toml"
alias cftm="v ~/.tmux.conf"
alias cfwt="v ~/.wezterm.lua"
alias cfskhd="v $DOTFILES_CONFIG_DIR/.config/skhd/skhdrc"

alias lgdf="lg -p $DOTFILES_DIR"
alias lgdc="lg -p $DOTFILES_CONFIG_DIR"

alias fdev="f ~/dev"
alias fdl="f ~/Downloads"

if type -q eza
	set -gx EZA_STANDARD_OPTIONS --icons --long --all
	alias ls="ll"
end

if type -q runiq # need $ cargo install runiq
	alias uniq="runiq"
	alias sort="runiq -f sorted"
end

alias ipy='ipython -i -c "%load_ext autoreload" "%autoreload 2"'

alias cdd="cd ~/dev"
alias cddl="cd ~/Downloads"

# Created by `pipx` on 2024-02-16 13:06:34
set PATH $PATH /Users/watchanan.c/.local/bin

# fzf.fish
set fzf_fd_opts --hidden --max-depth 5
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)" # open file with <C-o>
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\ct

# yazi
function fa
	set tmp (mktemp -t "yazi-cwd.XXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function yazi_install_plugins
	set current_dir (pwd)

	mkdir -p $CONFIG_DIR/yazi/plugins
	for plugin_repo in "dedukun/relative-motions.yazi" \
						"Reledia/glow.yazi" \
						"Reledia/miller.yazi" \
						"dedukun/bookmarks.yazi"
		echo "Plugin `$plugin_repo`"
		set onwer (string split "/" $plugin_repo -f1)
		set repository (string split "/" $plugin_repo -f2)
		set plugin_dir "$CONFIG_DIR/yazi/plugins/$repository"
		if test -d $plugin_dir
			cd $plugin_dir && git pull
		else
			git clone "https://github.com/$plugin_repo.git" $plugin_dir
		end
	end

	cd $current_dir
end

# zoxide, must be at the end
zoxide init fish | source
