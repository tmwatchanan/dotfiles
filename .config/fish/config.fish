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

alias v="nvim"
alias python3="python"
alias lg="lazygit"
alias cat="bat"
alias cdv="cd ~/.config/nvim"
alias cddf="cd ~/dev/dotfiles"
alias cddc="cd ~/dev/dotfiles-config"
alias cfv="cdv && nvim ."
alias cff="nvim ~/.config/fish/config.fish"
alias ref="source ~/.config/fish/config.fish"

alias cpv2git="cp -r ~/.config/nvim/* ~/dev/dotfiles-config/nvim/"
alias cpv2local="cp -r ~/dev/dotfiles-config/nvim ~/.config/"

alias lfd="cd ~/dev && lf"
alias lfdl="cd ~/Downloads && lf"

if type -q exa
	alias ls "exa -l -g --icons"
	alias ll "exa -l -g --icons --tree -L 2"
	alias lla "ll -a"
end

