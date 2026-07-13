#!/usr/bin/env bash
# herdr-lazygit.sh — open lazygit in a vertical split to the RIGHT of the
# currently focused pane, in that pane's working directory. The split closes
# automatically when you quit lazygit (the trailing `exit` ends the shell that
# hosts it). If the focused pane isn't inside a git repo, it shows a toast and
# skips the split entirely instead of flashing a failing lazygit pane.
#
# Bound in ~/.config/herdr/config.toml as a custom command:
#   [[keys.command]]
#   key = "prefix+g"
#   type = "shell"
#   command = "~/.config/herdr/herdr-lazygit.sh"
#
# It resolves the focused pane over herdr's socket API (herdr pane current)
# rather than relying on env vars, so it works from a detached shell command.
set -euo pipefail

# Extract the first "field":"value" string from a JSON blob on stdin.
json_field() { grep -oE "\"$1\":\"[^\"]*\"" | head -1 | cut -d'"' -f4; }

current=$(herdr pane current)
src=$(printf '%s' "$current" | json_field pane_id)
cwd=$(printf '%s' "$current" | json_field cwd)

[ -n "$src" ] || { echo "herdr-lazygit: no focused pane" >&2; exit 1; }

# Bail out early (no split) if the focused pane isn't inside a git work tree,
# so lazygit never flashes open in a doomed pane. Show a toast explaining why.
if [ -n "$cwd" ] && ! git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  herdr notification show "lazygit" --body "Not a git repository" --sound none
  exit 0
fi

new=$(herdr pane split --pane "$src" --direction right --focus \
        ${cwd:+--cwd "$cwd"} | json_field pane_id)

[ -n "$new" ] || { echo "herdr-lazygit: split failed" >&2; exit 1; }

herdr pane run "$new" "lazygit; exit"
