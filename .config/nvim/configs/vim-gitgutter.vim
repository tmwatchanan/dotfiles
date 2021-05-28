" symbols from https://mmore500.com/2020/04/12/vim-gitgutter.html
let g:gitgutter_sign_added = '█|'
let g:gitgutter_sign_modified = '█⫶'
let g:gitgutter_sign_removed = '█▁'
let g:gitgutter_sign_removed_first_line = '█▔'
let g:gitgutter_sign_modified_removed = '█▟'

" git add (chunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
" git undo (chunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
" fold all unchanged lines
nmap <leader>gz :GitGutterFold<CR>
" highlight changed lines
nmap <leader>gt :GitGutterLineHighlightsToggle<CR>
