set -g fish_greeting ''

# function fish_mode_prompt; end
set -g fish_key_bindings fish_default_key_bindings

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
# NOTE: Enable undercurl in neovim with wezterm (need a proper `~/.terminfo`)
# ref: https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines
#
# Only force TERM=wezterm when actually running under WezTerm (it exports
# WEZTERM_PANE). Under other terminals (e.g. Ghostty) this stays dormant so we
# keep the terminal's own TERM, which has an installed terminfo entry. Without
# this guard, a hardcoded TERM=wezterm makes ncurses tools warn "No entry for
# terminal type wezterm" whenever the wezterm terminfo isn't installed.
# Switch back to WezTerm and this re-activates automatically.
switch (uname)
    case Darwin
        if set -q WEZTERM_PANE
            set -gx TERM wezterm
        end
end

function fish_user_key_bindings
    bind \cl forward-word
    # bind \cl 'tput reset; clear; commandline -f repaint'
end

# homebrew — check /opt/homebrew (macOS) first; stat'ing the nonexistent
# /home/linuxbrew path stalls the filesystem for ~40ms on macOS.
if test -d /opt/homebrew # MacOS
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
else if test -d /home/linuxbrew/.linuxbrew # Linux
    set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
end
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
! set -q MANPATH; and set MANPATH ''
set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
! set -q INFOPATH; and set INFOPATH ''
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH


# git & GPG
set -x GPG_TTY $(tty)

# golang
set GOBIN $HOME/go/bin
fish_add_path $GOBIN

# ruby
fish_add_path /opt/homebrew/opt/ruby/bin

# rust & cargo
fish_add_path $HOME/.cargo/bin/

# node via fnm — activate so node/npm are on PATH (needed by nvim mason).
# --use-on-cd switches versions when entering dirs with .node-version/.nvmrc.
if type -q fnm
    fnm env --use-on-cd | source
end


# # >>> conda initialize >>>
# Cache `conda shell.fish hook` (spawns Python, ~120ms) and regenerate only when
# the conda binary changes. The trailing `conda activate base` is stripped so new
# shells don't auto-activate base (another ~130ms spawn) — run `conda activate`
# or `mamba activate` manually when you need it.
set -l __conda_exe /opt/homebrew/Caskroom/miniforge/base/bin/conda
if test -f $__conda_exe
    set -l __conda_cache (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/conda_hook.fish
    if not test -f $__conda_cache; or test $__conda_exe -nt $__conda_cache
        $__conda_exe shell.fish hook | string match -rv '^conda activate base$' >$__conda_cache
    end
    source $__conda_cache
else if test -f "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
    source "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
else
    fish_add_path /opt/homebrew/Caskroom/miniforge/base/bin
end

if test -f "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/mamba.fish"
    source "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<

# Created by `pipx` on 2024-02-16 13:06:34
set PATH $PATH /Users/watchanan.c/.local/bin


if type -q mamba
    activate_environment
end





fish_add_path $HOME/.local/bin

# zoxide, must be at the end
zoxide init fish | source
