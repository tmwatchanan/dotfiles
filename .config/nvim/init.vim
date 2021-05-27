let g:coc_global_extensions = [
\ 'coc-explorer',
\ 'coc-yank',
\ 'coc-json',
\ 'coc-html',
\ 'coc-css',
\ 'coc-html-css-support',
\ 'coc-prettier',
\ 'coc-yaml',
\ 'coc-highlight',
\ 'coc-tsserver',
\ 'coc-markdownlint',
\ 'coc-sql',
\ ]

call plug#begin()
"theme
Plug 'drewtempelmeyer/palenight.vim'

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
Plug 'airblade/vim-gitgutter'

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

" palenight
set background=dark
let g:palenight_terminal_italics=1
colorscheme palenight

"===============================================================================
" BUILT-IN CONFIGS
"===============================================================================
set nocompatible
"set clipboard=unnamedplus " uninstall xclip as well
" "filetyle plugin on
set history=10000 " must be after set nocompatible
set number
set relativenumber
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

" change multiple occurrences combined cgn with . (thanks u/Popeye_Lifting)
nnoremap <Leader>x /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <Leader>X ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN

"===============================================================================
" PLUGINS
"===============================================================================

" lualine ----------------------------------------------------------------------
lua require('lualine_config')
" lualine ----------------------------------------------------------------------

" fzf.vim and ripgrep-----------------------------------------------------------
" exclude file name search for Rg
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
" thanks junegunn for rg with preview
let $FZF_PREVIEW_COMMAND = 'rougify --theme thankful_eyes {} || batcat {}'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always --smart-case '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)
nnoremap <silent> <leader>f :Rg<CR>
"nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>/ :BLines<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>h/ :History/<CR> 

" Files + devicons by acepukas
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)  

    " Overriding fzf.vim's default :Files command.
    " Pass zero or one args to Files command (which are then passed to Fzf_dev). Support file path completion too.
    command! -nargs=? -complete=file Files call Fzf_dev(<q-args>)

    nnoremap <silent> <leader>F :Files<CR>
endif

function! Fzf_dev(qargs)
    let l:fzf_files_options = '--preview "batcat --theme="OneHalfDark" --style=numbers,changes --color=always {2..-1} | head -'.&lines.'" --expect=ctrl-t,ctrl-v,ctrl-x --multi --bind=ctrl-a:select-all,ctrl-d:deselect-all'

    function! s:files(dir)
        let l:cmd = $FZF_DEFAULT_COMMAND
        if a:dir != ''
            let l:cmd .= ' ' . shellescape(a:dir)
        endif
        let l:files = split(system(l:cmd), '\n')
        return s:prepend_icon(l:files)
    endfunction

    function! s:prepend_icon(candidates)
        let l:result = []
        for l:candidate in a:candidates
            let l:filename = fnamemodify(l:candidate, ':p:t')
            let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
            call add(l:result, printf('%s %s', l:icon, l:candidate))
        endfor

        return l:result
    endfunction

    function! s:edit_file(lines)
        if len(a:lines) < 2 | return | endif

        let l:cmd = get({'ctrl-x': 'split',
                    \ 'ctrl-v': 'vertical split',
                    \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')

        for l:item in a:lines[1:]
            let l:pos = stridx(l:item, ' ')
            let l:file_path = l:item[pos+1:-1]
            execute 'silent '. l:cmd . ' ' . l:file_path
        endfor
    endfunction

    call fzf#run({
                \ 'source': <sid>files(a:qargs),
                \ 'sink*':   function('s:edit_file'),
                \ 'options': '-m ' . l:fzf_files_options,
                \ 'window': { 'width': 0.9, 'height': 0.6 } })
endfunction
" fzf.vim and ripgrep-----------------------------------------------------------

" visa ------------------------------------------------------------------------
nnoremap <C-t> :Vista!!<CR>

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" visa ------------------------------------------------------------------------

" vim-todo-highlight ----------------------------------------------------------
let g:todo_highlight_config = {
            \   'NOTE': {
            \       'gui_fg_color': '#ffffff',
            \       'gui_bg_color': '#005f5f',
            \       'cterm_fg_color': 'white',
            \       'cterm_bg_color': '214'
            \   },
            \   'TODO': {
            \       'gui_fg_color': '#000000',
            \       'gui_bg_color': '#ffff00'
            \   },
            \   'OPTIMIZE': {
            \       'gui_bg_color': '#9467f9'
            \   },
            \   'REVIEW': {
            \       'gui_bg_color': '#02a4d3'
            \   }
            \ }
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
noremap <silent><expr> /  incsearch#go(<SID>incsearch_config({'is_stay': 0}))
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

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

" vim-fugitive ----------------------------------------------------------------
set diffopt+=vertical
autocmd BufReadPost fugitive://* set bufhidden=delete
nnoremap <leader>gs :G<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gj :diffget //3<CR>
" vim-fugitive ----------------------------------------------------------------

" vim-gitgutter ---------------------------------------------------------------
set updatetime=250

" symbols from https://mmore500.com/2020/04/12/vim-gitgutter.html
let g:gitgutter_sign_added = '█|'
let g:gitgutter_sign_modified = '█⫶'
let g:gitgutter_sign_removed = '█▁'
let g:gitgutter_sign_removed_first_line = '█▔'
let g:gitgutter_sign_modified_removed = "█▟"

" git add (chunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
" git undo (chunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
" fold all unchanged lines
nmap <leader>gz :GitGutterFold<CR>
" highlight changed lines
nmap <leader>gt :GitGutterLineHighlightsToggle<CR>
" vim-gitgutter ---------------------------------------------------------------

" ale -------------------------------------------------------------------------
let g:ale_disable_lsp = 1
let g:ale_sign_warning = '⚠'
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
" ale -------------------------------------------------------------------------

" coc -------------------------------------------------------------------------
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>x  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" coc -------------------------------------------------------------------------

" coc-explorer ----------------------------------------------------------------
nnoremap <C-e> :CocCommand explorer<CR>
" coc-explorer ----------------------------------------------------------------
