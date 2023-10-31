local M = {}
local wezterm = require 'wezterm'

function M.apply(config)
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
        {
            key = 'c',
            mods = 'CTRL|SHIFT',
            action = wezterm.action_callback(function(win, pane)
                require('helpers').copyAll(win, pane)
            end),
        },
    }
end

return M
