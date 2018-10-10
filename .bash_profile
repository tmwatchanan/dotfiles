#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx  

# pyenv
eval "$(pyenv init -)"
# pyenv-virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs

