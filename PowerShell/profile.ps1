$devPath = "D:\dev"
$dotfilesPath = "$devPath\dotfiles"
$dotfilesConfigPath = "$devPath\dotfiles-config"

Set-Alias v nvim
Set-Alias lg lazygit
Set-Alias f yazi

function reload {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait(". $")
    [System.Windows.Forms.SendKeys]::SendWait("PROFILE")
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}
function cfp { nvim $PROFILE }

function cfgit { nvim $env:USERPROFILE\.gitconfig }
function cfv { Set-Location $dotfilesConfigPath\nvim; nvim $dotfilesConfigPath\nvim\lua\config\keymaps.lua }
function cfwt { Set-Location $dotfilesPath\.config\wezterm; nvim $dotfilesPath\.config\wezterm\theme.lua }

function cdd { Set-Location $devPath }
function cd. { Set-Location $dotfilesPath }
function cd.c { Set-Location $dotfilesConfigPath }
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

function admin { Start-Process -Verb RunAs wt.exe pwsh.exe }
function cd- { cd - }
function .. { cd .. }

Set-Alias grep findstr

