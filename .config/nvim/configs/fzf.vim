" thanks junegunn for rg with preview
let $FZF_PREVIEW_COMMAND = 'rougify --theme thankful_eyes {} || batcat {}'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always --smart-case '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)
" to exclude file name search for Rg, add {'options': '--delimiter : --nth 4..'}
command! -bang -nargs=* RgNoFileNames
  \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always --smart-case '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
  \ <bang>0)
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fG :RgNoFileNames<CR>
nnoremap <silent> <leader>// :Lines<CR>
nnoremap <silent> <leader>/ :BLines<CR>
" change to nvim-telescope
" nnoremap <silent> <leader>f :Files<CR>
" nnoremap <silent> <leader>b :Buffers<CR>
" nnoremap <silent> <leader>t :Tags<CR>
" nnoremap <silent> <leader>hh :History<CR>
" nnoremap <silent> <leader>h: :History:<CR>
" nnoremap <silent> <leader>h/ :History/<CR> 
" nnoremap <silent> <leader>' :Marks<CR>

" Files + devicons by acepukas
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)  

    " Overriding fzf.vim's default :Files command.
    " Pass zero or one args to Files command (which are then passed to Fzf_dev). Support file path completion too.
    command! -nargs=? -complete=file Files call Fzf_dev(<q-args>)
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
