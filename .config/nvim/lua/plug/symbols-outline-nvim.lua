vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    keymaps = {
        close = "q", -- <esc>
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
}

vim.api.nvim_set_keymap('n', '<C-t>', ':SymbolsOutline<CR>', { noremap = true, silent = true })
