local M = {}
local wezterm = require 'wezterm'

function M.apply(config)
    config.color_scheme = 'Kanagawa (Gogh)'
    config.colors = {
        cursor_fg = 'black',
    }
    config.window_background_opacity = 0.9
    config.macos_window_background_blur = 50

    config.font = wezterm.font('VictorMono Nerd Font Mono', { weight = 'DemiBold' })
    config.font_size = 17

    config.enable_tab_bar = false
    config.window_decorations = 'RESIZE'
end

return M
