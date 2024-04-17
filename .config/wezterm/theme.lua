local wezterm = require 'wezterm'
local M = {}

function M.apply(config)
    config.color_scheme = 'Kanagawa (Gogh)'
    config.colors = {
        cursor_fg = 'black',
    }
    config.window_background_opacity = 0.9
    config.macos_window_background_blur = 50

    config.font = wezterm.font_with_fallback({
        { family = 'Maple Mono NF', weight = 'Regular' },
        { family = 'JuliaMono',     weight = 'Regular' },
    })
    config.font_size = 18

    config.enable_tab_bar = false
    config.window_decorations = 'RESIZE'
end

return M
