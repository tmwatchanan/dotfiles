call plug#begin()
"theme
Plug 'kuntau/ayu-vim' " 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

"status line
Plug 'hoob3rt/lualine.nvim'
Plug 'ryanoasis/vim-devicons'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'pseewald/nerdtree-tagbar-combined'

Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'idanarye/vim-merginal'

Plug 'tpope/vim-surround'

Plug 'wesQ3/vim-windowswap'

Plug 'chaoren/vim-wordmotion'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'

Plug 'Yggdroot/indentLine'

Plug 'mg979/vim-visual-multi'

Plug 'sakshamgupta05/vim-todo-highlight'

Plug 'chrisbra/csv.vim'

Plug 'glepnir/dashboard-nvim'

Plug 'tommcdo/vim-exchange'

Plug 'machakann/vim-highlightedyank'
call plug#end()

"===============================================================================
" THEME
"===============================================================================
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set t_Co=256

" ayu theme
let ayucolor="dark"
let ayu_comment_italic=1 " enable italic for comments
let ayu_string_italic=0  " enable italic for strings
let ayu_type_italic=0    " enable italic for types
let ayu_keyword_italic=0 " enable italic for keywords
colorscheme ayu

" palenight
"set background=dark
"colorscheme palenight
"let g:palenight_terminal_italics=1

"===============================================================================
" BUILT-IN CONFIGS
"===============================================================================
"set clipboard=unnamedplus " uninstall xclip as well
set nocompatible
" "filetyle plugin on
set number
set relativenumber
autocmd FileType nerdtree setlocal relativenumber
set cursorline
set encoding=utf-8
syntax on
set mouse=n " drag mouse for resizing splits
set pastetoggle=<F2>
set showmatch " show the matching part of the pair for [] {} and ()
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable automatic comment insertion
"set paste " paste without auto indentation
" indentation ===============================================
filetype plugin indent on
set autoindent
set expandtab " expand tabs into spaces
" default indentation
set shiftwidth=4
set softtabstop=4
set tabstop=4
" customized indentation based on filetype
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab
" indentation ===============================================

"keymapping
" leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" switch between split panes
nnoremap <M-j> <C-W><C-j>
nnoremap <M-k> <C-W><C-k>
nnoremap <M-l> <C-W><C-l>
nnoremap <M-h> <C-W><C-h>

" clipboard
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" hide search highlight
nnoremap <CR> :noh<CR><CR>

" switch back from insert mode to normal mode quickly
inoremap jk <esc>
inoremap kj <esc>

" search smart case, apply to /, *, #
set ignorecase
set smartcase
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

" Tab navigation like a web browser -------------------------------------------
"nnoremap <M-S-tab> :tabprevious<CR>
"nnoremap <M-tab>   :tabnext<CR>
"inoremap <M-S-tab> <Esc>:tabprevious<CR>i
"inoremap <M-tab>   <Esc>:tabnext<CR>i
nnoremap <M-t>     :tabnew<CR>
nnoremap <M-w>     :tabclose<CR>
inoremap <M-t>     <Esc>:tabnew<CR>
inoremap <M-w>     <Esc>:tabclose<CR>
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt
nnoremap <M-0> 10gt
" Tab navigation like a web browser -------------------------------------------

"===============================================================================
" PLUGINS
"===============================================================================

" lualine ----------------------------------------------------------------------
let g:lualine = {
    \'options' : {
    \  'theme' : 'gruvbox',
    \  'section_separators' : ['', ''],
    \  'component_separators' : ['', ''],
    \  'icons_enabled' : v:true,
    \},
    \'sections' : {
    \  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
    \  'lualine_b' : [ ['branch', {'icon': '',}, ], ],
    \  'lualine_c' : [ ['filename', {'file_status': v:true,},], ],
    \  'lualine_x' : [ 'encoding', 'fileformat', 'filetype' ],
    \  'lualine_y' : [ 'progress' ],
    \  'lualine_z' : [ 'location'  ],
    \},
    \'inactive_sections' : {
    \  'lualine_a' : [  ],
    \  'lualine_b' : [  ],
    \  'lualine_c' : [ 'filename' ],
    \  'lualine_x' : [ 'location' ],
    \  'lualine_y' : [  ],
    \  'lualine_z' : [  ],
    \},
    \'extensions' : [ 'fzf', 'fugitive', 'nerdtree' ],
    \}
lua require("lualine").setup()
" lualine ----------------------------------------------------------------------

" fzf.vim and ripgrep-----------------------------------------------------------
nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>/ :BLines<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>h/ :History/<CR> 
" fzf.vim and ripgrep-----------------------------------------------------------

" NERDTree --------------------------------------------------------------------
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>

" Tagbar
let g:tagbar_left = 1
"let g:tagbar_vertical = 25
let g:tagbar_position = 'bottom'
let NERDTreeWinPos = 'left'
nnoremap <C-t> :ToggleNERDTreeAndTagbar<CR>


nnoremap <C-f> :NERDTreeFind<CR>
" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif


" Synchronizing nerdtree with the currently opened file ________________________
"thanks to https://www.reddit.com/r/vim/comments/g47z4f/synchronizing_nerdtree_with_the_currently_opened/

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()
" Synchronizing nerdtree with the currently opened file _______________________

" NERDTree --------------------------------------------------------------------

" vim-todo-highlight ----------------------------------------------------------
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
                \ containedin=.*Comment.*
augroup END
"hi def link vimrc_todo Todo
"highlight vimrc_todo ctermbg=green guibg=green ctermfg=black guifg=black
" vim-todo-highlight ----------------------------------------------------------

" vim-wordmotion --------------------------------------------------------------
let g:wordmotion_nomap = 1
nmap w          <Plug>WordMotion_w
nmap b          <Plug>WordMotion_b
nmap gE         <Plug>WordMotion_gE
omap aW         <Plug>WordMotion_aW
cmap <C-R><C-W> <Plug>WordMotion_<C-R><C-W>
" vim-wordmotion --------------------------------------------------------------


" vim-easymotion --------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" hjkl motions
map <leader>l <Plug>(easymotion-lineforward)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" vim-easymotion --------------------------------------------------------------

" incsearch.vim x fuzzy x vim-easymotion --------------------------------------
" thanks to https://francopasut.github.io/editors/vim-easymotion/

" To enable fuzzy and fuzzy spell, add these converters
"                \   'converters': [
"                \     incsearch#config#fuzzy#converter(),
"                \     incsearch#config#fuzzyspell#converter()
"                \   ],
function! s:incsearch_config(...) abort
    return incsearch#util#deepextend(deepcopy({
                \   'converters': [
                \   ],
                \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
                \   'keymap': {
                \     "\<CR>": '<Over>(easymotion)'
                \   },
                \   'is_expr': 0,
                \   'is_stay': 1,
                \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 0}))

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" incsearch.vim x fuzzy x vim-easymotion --------------------------------------

" dashboard-nvim --------------------------------------------------------------
let g:dashboard_default_executive = 'fzf'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>
" dashboard-nvim --------------------------------------------------------------

" indentLine ------------------------------------------------------------------
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" indentLine ------------------------------------------------------------------
