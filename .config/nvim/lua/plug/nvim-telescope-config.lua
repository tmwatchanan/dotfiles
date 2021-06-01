local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-n>"] = false,
                ["<C-p>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
            },
        },
        set_env = {["COLORTERM"] = "truecolor"},
        
        prompt_prefix = '🔍 ',
        -- prompt_title = '',
        -- results_title = '',
        -- preview_title = '',
    }
}

vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>lua require("telescope.builtin").grep_string()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua require("telescope.builtin").tags()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>lua require("telescope.builtin").marks()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hh', '<cmd>lua require("telescope.builtin").oldfiles()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h/', '<cmd>lua require("telescope.builtin").search_history()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h:', '<cmd>lua require("telescope.builtin").command_history()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ht', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true, silent = true })
