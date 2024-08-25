alias v="nvim"
alias vv="sudo nvim"
# alias pip="uv pip"
alias conda="mamba"
alias e="mamba activate"
alias lg="lazygit"
alias f="yazi"
alias cat="bat"
alias df="duf"
alias du="dust"
alias bm="hyperfine"

alias bi="brew install"
alias bu="brew update"
alias bup="brew upgrade --fetch-HEAD"

alias fdev="f ~/dev"
alias fdl="f ~/Downloads"
alias ftm="f ~/tm"
alias cdd="cd ~/dev"
alias cdtm="cd ~/tm"
alias cddl="cd ~/Downloads"

alias vkh="v ~/tm/obsidian/know-how/README.md"
alias vmie="v ~/tm/obsidian/personal/README.md"
alias cdob="cd ~/tm/obsidian/know-how"
alias cfob="cdob & v .obsidian.vimrc"

alias cdc="cd $CONFIG_HOME"
alias cddf="cd $DOTFILES_DIR"
alias cddc="cd $DOTFILES_CONFIG_DIR"
alias cdv="cd $DOTFILES_CONFIG_DIR/nvim"
alias cfv="cdv & v"
alias cfvkm="cdv & v $DOTFILES_CONFIG_DIR/.config/nvim/lua/config/keymaps.lua"
alias cff="cddf & v $DOTFILES_DIR/.config/fish/config.fish"
alias ref="source $DOTFILES_DIR/.config/fish/config.fish"
alias cfyz="v $DOTFILES_DIR/.config/yazi/yazi.toml"
alias cftm="v ~/.tmux.conf"
alias cfwt="v $DOTFILES_DIR/.config/wezterm/keys.lua"
alias cfwtt="v $DOTFILES_DIR/.config/wezterm/theme.lua"
alias cfskhd="v $DOTFILES_CONFIG_DIR/skhd/skhdrc"
alias cfyb="v $DOTFILES_CONFIG_DIR/yabai/yabairc"
alias cfsb="v $DOTFILES_CONFIG_DIR/sketchybar/sketchybarrc"
alias cflg="v $DOTFILES_CONFIG_DIR/lazygit/config.yml"
alias cfssh="v $HOME/.ssh/config"
alias cfgit="v $HOME/.gitconfig"

alias lgdf="lg -p $DOTFILES_DIR"
alias lgdc="lg -p $DOTFILES_CONFIG_DIR"

# python
alias ipy='ipython -i -c "%load_ext autoreload" "%autoreload 2"'
# julia
alias jl="julia --project=. -i -e 'using Revise'"

# aws
alias ssm-ssh="aws ssm start-session --target"

if type -q eza
	set -gx EZA_STANDARD_OPTIONS --icons --long --all --color=always
	alias ls="ll"
end

if type -q runiq # need $ cargo install runiq
	alias uniq="runiq"
	alias sort="runiq -f sorted"
end

