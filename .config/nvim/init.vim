" plugin via vim-plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'chrisbra/NrrwRgn'
Plug 'leshill/vim-json'
Plug 'kien/ctrlp.vim'
Plug 'easymotion/vim-easymotion'

" Plug 'altercation/vim-colors-solarized'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
call plug#end()
filetype plugin on

" set <leader> key
let mapleader = "\<Space>"

" basic configs =============================================
set nocompatible
"filetyle plugin on
set number
set relativenumber
set cursorline
set encoding=utf-8
set noswapfile " disable swap file .swp
syntax on
set autoindent
set ts=4 " 1 tab = 4 spaces
set shiftwidth=4 " >> or << commands, shift lines by 4 spaces
set expandtab " expand tabs into spaces
set showmatch " show the matching part of the pair for [] {} and ()
" disable highlight in / (search) after pressing <Enter>
"set nohlsearch
" basic configs =============================================

" geek ======================================================
" find the next placeholder 
nnoremap <leader><Tab> <Esc>/<++><CR>"_c4l
inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
map <leader><Tab> <Esc>/<++><Enter>"_c4l
" switch back from insert mode to normal mode quickly
inoremap jk <Esc>
" geek ======================================================


" theme =====================================================
set background=dark
colorscheme onedark
let g:onedark_terminal_bold = 1
let g:onedark_terminal_italics = 1
let g:onedark_terminal_underline = 1
let g:airline_theme='onedark' 
"set notermguicolors
" theme =====================================================

" vim-easymotion ============================================
map <Leader> <Plug>(easymotion-prefix)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" hjkl motion
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
" vim-easymotion ============================================

" air-line ==================================================
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
" air-line ==================================================

" NERDCommenter =============================================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" NERDCommenter =============================================

" miscellaneous =============================================
set colorcolumn=80

" clear highlight on pressing <Esc>
nnoremap <Esc> <Esc>:noh<CR><Esc>

" ease for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" miscellaneous =============================================

" developement ==============================================
" enable all Python syntax highlighting features
let python_highlight_all = 1

" HTML
autocmd FileType html inoremap ;i <em></em><leader><Esc>Fet>i

" Markdown language
autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap ,b ****<++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~<++><Esc>F~hi
autocmd Filetype markdown inoremap ,e **<++><Esc>F*i
autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ,i ![](<++>)<++><Esc>F[a
autocmd Filetype markdown inoremap ,a [](<++>)<++><Esc>F[a
autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,l --------<Enter>

" developement ==============================================
