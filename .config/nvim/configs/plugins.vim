call plug#begin()
"theme
" Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'

"status line
Plug 'hoob3rt/lualine.nvim'
Plug 'ryanoasis/vim-devicons'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() } }
Plug 'weirongxu/coc-explorer'

Plug 'liuchengxu/vista.vim'

Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'idanarye/vim-merginal'
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'

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
Plug 'triglav/vim-visual-increment'

Plug 'sakshamgupta05/vim-todo-highlight'

Plug 'chrisbra/csv.vim'

Plug 'glepnir/dashboard-nvim'

Plug 'tommcdo/vim-exchange'

Plug 'chrisbra/NrrwRgn'

Plug 'dense-analysis/ale'

Plug 'tpope/vim-repeat'

Plug 'svermeulen/vim-easyclip'

Plug 'tpope/vim-commentary'

Plug 'craigemery/vim-autotag'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'

Plug 'christoomey/vim-tmux-navigator'

Plug 'jeetsukumaran/vim-indentwise'
call plug#end()
