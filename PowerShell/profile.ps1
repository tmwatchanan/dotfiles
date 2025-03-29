$dotfilesPath = "D:\dev\dotfiles"
$dotfilesConfigPath = "D:\dev\dotfiles-config"

Set-Alias v nvim
Set-Alias lg lazygit

function reload { . $PROFILE }
function cfp { nvim $PROFILE }

function cfgit { nvim $env:USERPROFILE/.gitconfig }

function cd. { set-location $dotfilesPath }
function cd.c { set-location $dotfilesConfigPath }
