if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors " enable true colors support
endif

set t_Co=256

" palenight
" set background=dark
" let g:palenight_terminal_italics=1
" colorscheme palenight

" ayu
" let ayucolor="light"  " light, mirage, dark
" colorscheme ayu

" oceanicnext
" colorscheme oceanicnext

" material
" let g:material_terminal_italics = 1
" let g:material_theme_style = 'default'
" colorscheme material

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
let g:seoul256_background = 235
let g:seoul256_srgb = 1
colorscheme seoul256
