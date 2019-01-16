" plugin via vim-plug
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'chrisbra/NrrwRgn'
Plug 'leshill/vim-json'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'

" file browsing
Plug 'ervandew/supertab'
Plug 'Xuyuanp/nerdtree-git-plugin'
" tag browsing
Plug 'majutsushi/tagbar'

" syntax checking
Plug 'vim-syntastic/syntastic'
" syntax highlighting
Plug 'sheerun/vim-polyglot'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" auto completion
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"
" supertab
Plug 'ervandew/supertab'

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
autocmd FileType nerdtree setlocal relativenumber
set cursorline
set encoding=utf-8
set noswapfile " disable swap file .swp
syntax on
set autoindent
set ts=4 " 1 tab = 4 spaces (ts is tabstop)
set shiftwidth=4 " >> or << commands, shift lines by 4 spaces
set expandtab " expand tabs into spaces
set showmatch " show the matching part of the pair for [] {} and ()
" disable highlight in / (search) after pressing <Enter>
"set nohlsearch
" basic configs =============================================

" auto-reload configuration =================================
" auto-reload configuration =================================

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

" tabularize
if exists(":Tabularize")
  nmap ,a= :Tabularize /=<CR>
  vmap ,a= :Tabularize /=<CR>
  nmap ,a: :Tabularize /:\zs<CR>
  vmap ,a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
" tabularize

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

" ctrlp =====================================================
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height
" ctrlp =====================================================

" ale =======================================================
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" ale =======================================================

" YouCompleteMe =============================================
" ref: https://stackoverflow.com/a/22253548/7150241
" make YCM compatible with UltiSnips (using supertab)"
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" auto close preview window without pressing ctrl-w z
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" auto trigger completion without pressing ctrl-space
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 1

" python language
let g:ycm_python_binary_path = 'python'
" YouCompleteMe =============================================

" UltiSnips =================================================
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" UltiSnips =================================================

" Tagbar ====================================================
nmap <F8> :TagbarToggle<CR>
" Tagbar ====================================================

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
" NERDtree
" map <C-n> :NERDTreeToggle<CR>"
" map <C-n> :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle %<CR>
let g:NERDTreeWinSize = 25
let g:NERDTreeShowLineNumbers = 1

" Tab navigation like Firefox.
nnoremap <A-S-tab> :tabprevious<CR>
nnoremap <A-tab>   :tabnext<CR>
nnoremap <A-t>     :tabnew<CR>
nnoremap <A-w>     :tabclose<CR>
inoremap <A-S-tab> <Esc>:tabprevious<CR>i
inoremap <A-tab>   <Esc>:tabnext<CR>i
inoremap <A-t>     <Esc>:tabnew<CR>
inoremap <A-w>     <Esc>:tabclose<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt
" nnoremap H gT
" nnoremap L gt

" enable all Python syntax highlighting features
let python_highlight_all = 1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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

" LaTeX

    " Open corresponding.pdf
	map <leader>p :!zathura %:r.pdf &<CR><CR>
	" Word count:
	autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
	autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
	" Compile document using xelatex:
	autocmd FileType tex inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
	autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>
	" Code snippets
	autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,li <Enter>\item<Space>
	autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,bt {\blindtext}
	autocmd FileType tex inoremap ,nu $\varnothing$
	autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

" developement ==============================================

