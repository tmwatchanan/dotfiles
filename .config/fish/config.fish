if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim

set GOBIN $HOME/go/bin
fish_add_path $GOBIN

fish_add_path /opt/homebrew/opt/ruby/bin

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
set -gx DOTFILE_DIR ~/dev/dotfiles
set -gx DOTFILE_CONFIG_DIR ~/dev/dotfiles-config

alias v="nvim"
alias vv="sudo nvim"
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
alias cdv="cd $CONFIG_DIR/nvim"
alias cddf="cd $DOTFILE_DIR"
alias cddc="cd $DOTFILE_CONFIG_DIR"
alias cfv="cdv && nvim"
alias cfv="cdv && nvim $CONFIG_DIR/nvim/lua/config/keymaps.lua"
alias cff="nvim $CONFIG_DIR/fish/config.fish"
alias ref="source $CONFIG_DIR/fish/config.fish"
alias cfyz="nvim $CONFIG_DIR/yazi/yazi.toml"
alias cftm="nvim ~/.tmux.conf"
alias cfwt="nvim ~/.wezterm.lua"
alias cfskhd="nvim $CONFIG_DIR/skhd/skhdrc"

alias baktm="cp ~/.tmux.conf $DOTFILE_DIR/; cddf; lazygit"
alias bakwt="cp ~/.wezterm.lua $DOTFILE_DIR/; cp $CONFIG_DIR/wezterm/* $DOTFILE_DIR/.config/wezterm/; cddf; lazygit"
alias bakyz="cp $CONFIG_DIR/yazi/{yazi.toml,keymap.toml,init.lua} $DOTFILE_DIR/.config/yazi/; cddf; lazygit"
alias bakf="cp $CONFIG_DIR/fish/{config.fish,fish_plugins} $DOTFILE_DIR/.config/fish/; cddf; lazygit"
alias bakv="cp -r $CONFIG_DIR/nvim/* $DOTFILE_CONFIG_DIR/nvim/; cddc; lazygit"
alias cpv="cp -r $DOTFILE_CONFIG_DIR/nvim $CONFIG_DIR/"
alias lgdf="cddf; lazygit"
alias lgdc="cddc; lazygit"

alias fdev="cd ~/dev && f"
alias fdl="cd ~/Downloads && f"

if type -q exa
	alias ls "exa -l -g --icons"
	alias ll "exa -l -g --icons --tree -L 2"
	alias lla "ll -a"
end

alias ipy='ipython -i -c "%load_ext autoreload" "%autoreload 2"'

alias cdd="cd ~/dev"
alias cdpreda="cd ~/dev/preda"
alias cdvks="cd ~/dev/vks-thds-k8s"
alias cdvksllm="cd ~/dev/vks-thds-k8s/apps/lmllm-monitoring"
alias cdllm="cd ~/dev/lmllm"
alias cdtrec="cd ~/dev/sequential-recommender"

# Created by `pipx` on 2024-02-16 13:06:34
set PATH $PATH /Users/watchanan.c/.local/bin

# fzf
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
fzf_configure_bindings --directory=\cf

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
	mkdir -p $CONFIG_DIR/yazi/plugins

	for plugin_repo in "dedukun/relative-motions.yazi" \
						"Reledia/glow.yazi" \
						"Reledia/miller.yazi"
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
end

# zoxide, must be at the end
zoxide init fish | source
