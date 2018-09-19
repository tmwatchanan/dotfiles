" plugin via vim-plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdcommenter'
call plug#end()

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

set nocompatible
"filetyle plugin on

" enable syntax highlighting
syntax on
colorscheme onedark

" show line numbers
set number
set relativenumber

" set encoding to UTF-8
set encoding=utf-8

" disable swap file .swp
set noswapfile

" disable highlight in / (search) after pressing <Enter>
"set nohlsearch

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" find the next placeholder 
inoremap <Space><Space> <Esc>/<++><CR>"_c4l

" switch back from insert mode to normal mode quickly
inoremap jk <Esc>

autocmd FileType html inoremap ;i <em></em><Space><Esc>Fet>i

set colorcolumn=80

" set <leader> key
:let mapleader = " "

" clear highlight on pressing <Esc>
nnoremap <Esc> <Esc>:noh<CR><Esc>