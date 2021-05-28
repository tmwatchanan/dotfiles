set diffopt+=vertical
autocmd BufReadPost fugitive://* set bufhidden=delete
nnoremap <leader>gs :G<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gj :diffget //3<CR>
