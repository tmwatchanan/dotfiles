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
    config.font_size = 18
    config.line_height = 0.80

    config.enable_tab_bar = false
    config.window_decorations = 'RESIZE'
end

return M
