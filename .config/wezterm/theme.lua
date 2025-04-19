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

    if wezterm.target_triple == 'x86_64-pc-windows-msvc' then -- Windows
        config.window_background_opacity = 1.0
        config.font_size = 12
        config.enable_tab_bar = true
        config.initial_cols = 120
        config.initial_rows = 40

        -- config.default_prog = { 'powershell.exe' }
        config.default_domain = 'WSL:Ubuntu'
    end
end

return M
