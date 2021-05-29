" switch between split panes
nnoremap <M-j> <C-W><C-j>
nnoremap <M-k> <C-W><C-k>
nnoremap <M-l> <C-W><C-l>
nnoremap <M-h> <C-W><C-h>

Plug 'christoomey/vim-tmux-navigator'
if &term == 'screen-256color'
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
endif

" resize panes
nnoremap <M--> <C-W>3-
noremap <M-=> <C-W>3+
nnoremap <M-,> <C-W>3<
nnoremap <M-.> <C-W>3>
