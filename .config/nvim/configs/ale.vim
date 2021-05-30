let g:ale_disable_lsp = 1
let g:ale_virtualtext_cursor = 0

" ● ◉  ⚠
let g:ale_sign_error = ''
let g:ale_sign_warning = '◉'
highlight ALEErrorSign ctermfg=9 guifg=#FF1A37
highlight ALEWarningSign ctermfg=11 guifg=#FFD700

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
