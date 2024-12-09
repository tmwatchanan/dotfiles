local wezterm = require 'wezterm'

local config = wezterm.config_builder()

require('theme').apply(config)
require('keys').apply(config)
require('zen')

config.default_cwd = '/Users/watchanan.c/dev/'

return config
