local M = {}

function M.apply(config)
    -- took from https://github.com/EdenEast/nightfox.nvim/blob/main/extra/nightfox/nightfox_wezterm.toml
    config.colors = {
        foreground    = '#cdcecf',
        background    = '#192330',
        cursor_bg     = '#cdcecf',
        cursor_fg     = '#192330',
        cursor_border = '#cdcecf',
        selection_fg  = '#cdcecf',
        selection_bg  = '#2b3b51',
        scrollbar_thumb = '#71839b',
        split         = '#131a24',
        ansi    = { '#393b44', '#c94f6d', '#81b29a', '#dbc074', '#719cd6', '#9d79d6', '#63cdcf', '#dfdfe0' },
        brights = { '#575860', '#d16983', '#8ebaa4', '#e0c989', '#86abdc', '#baa1e2', '#7ad5d6', '#e4e4e5' },
        indexed = { [16] = '#f4a261', [17] = '#d67ad2' },
    }
end

return M
