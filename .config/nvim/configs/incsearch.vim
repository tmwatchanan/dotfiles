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

