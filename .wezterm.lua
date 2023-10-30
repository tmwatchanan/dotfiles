local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Kanagawa (Gogh)'
config.colors = {
    cursor_fg = 'black',
}
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50

config.font = wezterm.font('VictorMono Nerd Font Mono', { weight = 'DemiBold' })
config.font_size = 17

config.enable_tab_bar = false
config.window_decorations = 'RESIZE'

config.keys = {
    {
        key = ',',
        mods = 'CMD',
        action = wezterm.action.SpawnCommandInNewTab {
            cwd = os.getenv('WEZTERM_CONFIG_DIR'),
            set_environment_variables = {
                TERM = 'xterm-256color',
            },
            args = {
                'nvim',
                os.getenv('WEZTERM_CONFIG_FILE'),
            },
        },
    },
}

config.default_cwd = '/Users/watchanan.c/dev/'

return config
