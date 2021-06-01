if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors " enable true colors support
endif

set t_Co=256


" source ~/.config/nvim/themes/ayu.vim
" source ~/.config/nvim/themes/material.vim
" source ~/.config/nvim/themes/palenight.vim
" source ~/.config/nvim/themes/seoul256.vim
source ~/.config/nvim/themes/tokyonight.vim
