set -g fish_greeting ''

# function fish_mode_prompt; end
set -g fish_key_bindings fish_default_key_bindings

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
# NOTE: Enable undercurl in neovim with wezterm (need a proper `~/.terminfo`)
# ref: https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines
set -gx TERM wezterm

# homebrew
if test -d /home/linuxbrew/.linuxbrew # Linux
    set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
else if test -d /opt/homebrew # MacOS
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
end
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
! set -q MANPATH; and set MANPATH ''
set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
! set -q INFOPATH; and set INFOPATH ''
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH


function install_programs
    brew install yazi --HEAD
    brew install lazygit --HEAD
    brew install eza
    brew install bat --HEAD
    brew install zoxide --HEAD
    brew install duf --HEAD
    brew install dust --HEAD
    brew install hyperfine --HEAD

    cargo install runiq
end


# git & GPG
set -x GPG_TTY $(tty)

# golang
set GOBIN $HOME/go/bin
fish_add_path $GOBIN

# ruby
fish_add_path /opt/homebrew/opt/ruby/bin

# rust & cargo
fish_add_path $HOME/.cargo/bin/


# # >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
    else
        fish_add_path /opt/homebrew/Caskroom/miniforge/base/bin
    end
end

if test -f "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/mamba.fish"
    source "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<

# Created by `pipx` on 2024-02-16 13:06:34
set PATH $PATH /Users/watchanan.c/.local/bin


set -x THEFUCK_OVERRIDDEN_ALIASES 'mamba,ll'
thefuck --alias | source

source ~/.config/fish/lmwn.fish

mamba_activate $PWD





# zoxide, must be at the end
zoxide init fish | source
