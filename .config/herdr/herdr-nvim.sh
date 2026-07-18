#!/usr/bin/env bash
# herdr-nvim.sh — open nvim in a NEW TAB, in the focused pane's working
# directory, and focus it. The tab closes automatically when you quit nvim
# (the trailing `exit` ends the shell that hosts it).
#
# Bound in ~/.config/herdr/config.toml as a custom command:
#   [[keys.command]]
#   key = "prefix+t"
#   type = "shell"
#   command = "~/.config/herdr/herdr-nvim.sh"
#
# It resolves the focused pane over herdr's socket API (herdr pane current)
# rather than relying on env vars, so it works from a detached shell command.
set -euo pipefail

# Extract the first "field":"value" string from a JSON blob on stdin.
json_field() { grep -oE "\"$1\":\"[^\"]*\"" | head -1 | cut -d'"' -f4; }

cwd=$(herdr pane current | json_field cwd)

# Create a focused tab in the same cwd; run nvim in its root pane. The first
# pane_id in the response is the new tab's root pane. --env SHELL=/bin/sh so the
# tab's root pane spawns a near-instant login sh instead of the default fish,
# whose startup would flash a prompt before nvim takes over.
new=$(herdr tab create --focus --env SHELL=/bin/sh ${cwd:+--cwd "$cwd"} | json_field pane_id)

[ -n "$new" ] || { echo "herdr-nvim: tab create failed" >&2; exit 1; }

herdr pane run "$new" "nvim; exit"
