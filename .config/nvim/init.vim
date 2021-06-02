source ~/.config/nvim/configs/coc-extensions.vim
source ~/.config/nvim/configs/plugins.vim
source ~/.config/nvim/configs/theme.vim
source ~/.config/nvim/configs/tab.vim

"===============================================================================
" BUILT-IN CONFIGS
"===============================================================================
set nocompatible
"set clipboard=unnamedplus " uninstall xclip as well
" "filetyle plugin on
set updatetime=250
" set timeoutlen=500
set history=10000 " must be after set nocompatible
set number
set relativenumber
set signcolumn=yes
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
hi markdownItalic gui=italic cterm=italic
hi markdownBold gui=bold cterm=bold
hi Comment gui=italic cterm=italic
" buffer
set hidden
" highlight on yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }
augroup END

command So execute "source ~/.config/nvim/init.vim"

"keymapping
" leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" working directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" buffer
nnoremap <silent> <leader>d :bd<CR>

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
" inoremap kj <esc>
" move to front or back of the line in insert mode
inoremap jj <esc>I
inoremap JJ <esc>A
" create a new line in insert mode
inoremap jl <esc><S-o>
inoremap j; <esc>o

" search smart case, apply to /, *, #
set ignorecase
set smartcase
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

" change multiple occurrences combined cgn with . (thanks u/Popeye_Lifting)
nnoremap <Leader>. /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <Leader>, ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

" jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

source ~/.config/nvim/configs/splits.vim

"===============================================================================
" PLUGINS
"===============================================================================

lua require("plug/gitsigns-nvim")
lua require("plug/lspkind-nvim")
lua require("plug/lspsaga-nvim")
lua require("plug/lualine_config")
lua require("plug/nvim-bufferline")
lua require("plug/nvim-compe")
lua require("plug/nvim-lspconfig")
lua require("plug/nvim-telescope-config")
lua require("plug/nvim-treesitter-context")
lua require("plug/nvim-treesitter")
lua require("plug/symbols-outline-nvim")
lua require("plug/trouble-nvim")

" source ~/.config/nvim/configs/ale.vim
" source ~/.config/nvim/configs/coc-explorer.vim
" source ~/.config/nvim/configs/coc.nvim.vim
source ~/.config/nvim/configs/dashboard-nvim.vim
source ~/.config/nvim/configs/fzf.vim
source ~/.config/nvim/configs/incsearch.vim
source ~/.config/nvim/configs/indent-blankline.nvim.vim
source ~/.config/nvim/configs/lsp.vim
source ~/.config/nvim/configs/nvim-tree.lua.vim
source ~/.config/nvim/configs/rainbow_parentheses.vim
source ~/.config/nvim/configs/vim-easymotion.vim
source ~/.config/nvim/configs/vim-fugitive.vim
" source ~/.config/nvim/configs/vim-gitgutter.vim
source ~/.config/nvim/configs/vim-hexokinase.vim
" source ~/.config/nvim/configs/vim-signify.vim
source ~/.config/nvim/configs/vim-todo-highlight.vim
source ~/.config/nvim/configs/vim-wordmotion.vim
" source ~/.config/nvim/configs/vista.vim
