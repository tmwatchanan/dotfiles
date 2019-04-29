# Set up the prompt

# Path to your oh-my-zsh installation.
  export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

# ranger (file manager)
export EDITOR=nvim

# make all scripts in ~/bin global
export PATH=$HOME/bin:$PATH

# flutter
export PATH=$PATH:$HOME/dev/flutter/bin

# pure theme
fpath=( "$HOME/.zfunctions" $fpath )
plugins=(sudo systemd vi-mode tmux wd z history colored-man-pages extract git copyfile gem npm yarn ruby gem composer python pip docker zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
autoload -Uz promptinit; promptinit
# prompt spaceship
# prompt pure

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# auto cd paths
setopt auto_cd

# Use modern completion system
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias sudo='sudo '
alias vim=nvim
alias v=nvim
alias vv='sudo nvim'
alias cdd="cd $HOME/dev"
alias cfv=" nvim ~/.config/nvim/init.vim"
alias cfz=" nvim ~/.zshrc"
alias cfb=" nvim ~/.bashrc"
alias cfrxvt=" nvim ~/.Xdefaults"
alias cfk=" nvim ~/.config/kitty/kitty.conf"
alias cfi3=" nvim ~/.config/i3/config"
alias cfp=" nvim ~/.config/polybar/config"
alias cfr=" nvim ~/.config/ranger/rc.conf"
alias cfc="nvim ~/.config/compton.conf"
alias cftm="nvim ~/.tmux.conf"
alias cv="conda activate cv"
alias st="speedtest-cli"
alias rg="ranger --cmd='cd pwd'"
alias rgg="urxvt -e ranger --cmd='cd pwd' &"
alias cat="bat"
alias rmp="shred -zvu -n 5"
alias j="jobs -l"
alias sudodolphin="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true dolphin"
alias cdtk="cd /var/www/html/tksrisangar"

# useful functions

# download PDF from sci-hub
shdl() { 
    curl -O $(curl -s http://sci-hub.tw/"$@" | grep location.href | grep -o http.*pdf);
}
# make a folder and cd at the same time
mkcd() { mkdir -p $1; cd $1; }
# compress/extract .tar.gz 
targz() { tar -zcvf $1.tar.gz $1; rm -r $1; }
untargz() { tar -zxvf $1; rm -r $1; }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tommie/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tommie/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tommie/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tommie/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#.# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red') # To have commands st

# nvm (node.js)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
