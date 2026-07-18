#!/usr/bin/env bash
# herdr-hunk.sh — open hunk (diff review TUI) in a vertical split to the RIGHT
# of the currently focused pane, in that pane's working directory. The split
# closes automatically when you quit hunk (the trailing `exit` ends the shell
# that hosts it). If the focused pane isn't inside a git repo, it shows a toast
# and skips the split entirely instead of flashing a failing hunk pane.
#
# hunk runs `hunk diff` (working-tree changes); watch = true in
# ~/.config/hunk/config.toml keeps the review live while an agent edits.
#
# Bound in ~/.config/herdr/config.toml as a custom command:
#   [[keys.command]]
#   key = "prefix+u"
#   type = "shell"
#   command = "~/.config/herdr/herdr-hunk.sh"
#
# It resolves the focused pane over herdr's socket API (herdr pane current)
# rather than relying on env vars, so it works from a detached shell command.
set -euo pipefail

# Extract the first "field":"value" string from a JSON blob on stdin.
json_field() { grep -oE "\"$1\":\"[^\"]*\"" | head -1 | cut -d'"' -f4; }

current=$(herdr pane current)
src=$(printf '%s' "$current" | json_field pane_id)
cwd=$(printf '%s' "$current" | json_field cwd)

[ -n "$src" ] || { echo "herdr-hunk: no focused pane" >&2; exit 1; }

# Bail out early (no split) if the focused pane isn't inside a git work tree,
# so hunk never flashes open in a doomed pane. Show a toast explaining why.
if [ -n "$cwd" ] && ! git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  herdr notification show "hunk" --body "Not a git repository" --sound none
  exit 0
fi

# --env SHELL=/bin/sh so the split spawns a near-instant login sh instead of the
# default fish, whose startup would flash a prompt before hunk takes over.
new=$(herdr pane split --pane "$src" --direction right --focus \
        --env SHELL=/bin/sh ${cwd:+--cwd "$cwd"} | json_field pane_id)

[ -n "$new" ] || { echo "herdr-hunk: split failed" >&2; exit 1; }

herdr pane run "$new" "hunk diff; exit"
