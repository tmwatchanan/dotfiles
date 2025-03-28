Set-Alias v nvim
Set-Alias lg lazygit

function goto_dotfiles { set-location "D:\dev\dotfiles" }
function goto_dotfiles-config { set-location "D:\dev\dotfiles-config" }
Set-Alias cd. goto_dotfiles
Set-Alias cd.c goto_dotfiles-config