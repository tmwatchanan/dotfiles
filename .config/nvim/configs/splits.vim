set splitbelow
set splitright

highlight VertSplit guibg=#3b4261 guifg=#3b4261
highlight ColorColumn guibg=#1f2335

" switch between split panes
nnoremap <M-j> <C-W><C-j>
nnoremap <M-k> <C-W><C-k>
nnoremap <M-l> <C-W><C-l>
nnoremap <M-h> <C-W><C-h>

if &term == 'screen-256color'
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
endif

" resize panes
nnoremap <silent> <M--> :resize -3<CR>
nnoremap <silent> <M-=> :resize +3<CR>
nnoremap <silent> <M-,> :vertical resize -3<CR>
nnoremap <silent> <M-.> :vertical resize +3<CR>
