local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Send BOTH Option keys as Alt (macOS composes left-Option into special chars by
-- default). Matches ghostty macos-option-as-alt / kitty macos_option_as_alt, and lets
-- herdr's prefix-free Opt+Shift+h/j/k/l/n/p chords reach it from either Option key.
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Kitty keyboard protocol (default OFF in WezTerm): needed so modified chords like
-- Alt+Shift+h are sent disambiguated (CSI u) instead of the legacy `ESC H`, which
-- herdr can't map to `alt+shift+h`. Required for the prefix-free Opt+Shift bindings.
config.enable_kitty_keyboard = true

require('theme').apply(config)
require('keys').apply(config)
require('zen')

return config
