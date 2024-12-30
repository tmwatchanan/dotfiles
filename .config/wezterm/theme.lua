local wezterm = require 'wezterm'
local M = {}

function M.apply(config)
    require('themes.kanagawa').apply(config)

    config.window_background_opacity = 0.93
    config.macos_window_background_blur = 50

    config.font = wezterm.font_with_fallback({
        { family = 'Maple Mono NF', weight = 'Regular' },
        { family = 'JuliaMono',     weight = 'Regular' },
    })
    config.font_size = 17.2
    config.line_height = 0.75

    config.enable_tab_bar = false
    config.window_decorations = 'RESIZE'

    config.window_padding = {
        left = '0.5cell',
        right = '0cell',
        top = '0.3cell',
        bottom = '0cell',
    }
end

return M
