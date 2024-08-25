set fzf_fd_opts --hidden --max-depth 5
set fzf_edit "become($EDITOR {} &> /dev/tty)"
set fzf_directory_opts --bind ctrl-h:toggle-preview \
					   --bind ctrl-o:$fzf_edit \
					   --bind ctrl-e:$fzf_edit \
					   --bind ctrl-y:"execute-silent(echo {} | pbcopy)+abort"
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_preview_file_cmd preview # requires `jisher install kidonng/preview.fish`
set fzf_preview_dir_cmd lo --group-directories-first # requires `fisher install plttn/fish-eza`
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\ct

