$dotfilesPath = "D:\dev\dotfiles"
$dotfilesConfigPath = "D:\dev\dotfiles-config"

Set-Alias v nvim
Set-Alias lg lazygit

function reload { . $PROFILE }
function cfp { nvim $PROFILE }

function cfgit { nvim $env:USERPROFILE\.gitconfig }
function cfwt { nvim $dotfilesPath\.config\wezterm\theme.lua }

function cd. { set-location $dotfilesPath }
function cd.c { set-location $dotfilesConfigPath }
function lg. {
    Push-Location -EA Stop $dotfilesPath
    lazygit
    Pop-Location
}
function lg.c {
    Push-Location -EA Stop $dotfilesConfigPath
    lazygit
    Pop-Location
}

Set-Alias grep findstr

