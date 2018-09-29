" plugin via vim-plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'chrisbra/NrrwRgn'
Plug 'leshill/vim-json'

Plug 'altercation/vim-colors-solarized'
call plug#end()
filetype plugin on

let g:solarized_termcolors=256
let g:solarized_bold = 1
let g:solarized_underline = 1
let g:solarized_italic = 1

set background=dark
"set notermguicolors
colorscheme solarized
"colorscheme material-monokai
let g:materialmonokai_italic=1
let g:materialmonokai_subtle_spell=1
let g:materialmonokai_custom_lint_indicators=0
let g:airline_theme='materialmonokai'
let g:materialmonokai_subtle_airline=1

"colorscheme onedark

set nocompatible
"filetyle plugin on

" set <leader> key
let mapleader = "\<Space>"

" enable syntax highlighting
syntax on

" change highlight color when searching with /
"highlight Search ctermfg=black

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
nnoremap <leader><leader> <Esc>/<++><CR>"_c4l

" switch back from insert mode to normal mode quickly
inoremap jk <Esc>

autocmd FileType html inoremap ;i <em></em><leader><Esc>Fet>i

set colorcolumn=80

" clear highlight on pressing <Esc>
nnoremap <Esc> <Esc>:noh<CR><Esc>

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

