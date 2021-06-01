local saga = require 'lspsaga'

saga.init_lsp_saga {
    error_sign = '', -- 
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
}

local defaults = {
    height = 10,
}

vim.api.nvim_set_keymap('n', 'gh', ':Lspsaga lsp_finder<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', ':Lspsaga preview_definition<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'gs', ':Lspsaga signature_help<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>ca', ':<C-U>Lspsaga range_code_action<CR>', { noremap = true, silent = true })
