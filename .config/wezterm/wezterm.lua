local wezterm = require 'wezterm'

local config = wezterm.config_builder()

require('theme').apply(config)
require('keys').apply(config)
require('zen')

return config
