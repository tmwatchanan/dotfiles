function NvimTreeLineNumber()
    set relativenumber
    set signcolumn=number
endfunction

augroup nvim_tree_line_number
    autocmd!
    autocmd BufWinEnter NvimTree call NvimTreeLineNumber()
augroup END

let g:nvim_tree_width = 40
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ]
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_lsp_diagnostics = 1

lua <<EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
    ["<CR>"] = tree_cb("cd"),
    ["<BS>"] = tree_cb("dir_up"),
    ["h"] = tree_cb("close_node"),
    ["l"] = tree_cb("open_node"),
}
EOF

nnoremap <silent> <C-e> :NvimTreeToggle<CR>
nnoremap <silent> <leader>e :NvimTreeFindFile<CR>
" nnoremap <silent> <leader>r :NvimTreeRefresh<CR>

" auto change dir when :cd
lua <<EOF
local M = {}

require'nvim-tree.events'.on_nvim_tree_ready(function ()
  vim.g.nvim_tree_ready = 1
end)

function M.update_cwd()
  if vim.g.nvim_tree_ready == 1 then
    local view = require'nvim-tree.view'
    local lib = require'nvim-tree.lib'
    if view.win_open() then
      lib.change_dir(vim.fn.getcwd())
    end
  end
end

vim.api.nvim_exec([[
  augroup NvimTreeConfig
    au!
    au DirChanged * lua NvimTreeConfig.update_cwd()
  augroup END
  ]], false)

_G.NvimTreeConfig = M
return M
EOF
