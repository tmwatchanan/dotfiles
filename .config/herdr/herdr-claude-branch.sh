#!/usr/bin/env bash
# herdr-claude-branch.sh — branch (fork) the focused pane's Claude Code
# conversation into a NEW TAB, and focus it.
#
# It resolves the focused pane over herdr's socket API (herdr pane current),
# reads that pane's Claude session ID (agent_session.value) and cwd, then opens
# a new tab in the same cwd running `claude --resume <id> --fork-session`. That
# forks the exact conversation into a fresh session ID: the original session in
# the source pane is untouched, and this tab explores an independent branch.
# The new tab is named "fork-<source tab label>". When you quit claude the tab
# stays open at a shell prompt (no trailing `exit`), so you can resume or rerun.
#
# Bound in ~/.config/herdr/config.toml as a custom command:
#   [[keys.command]]
#   key = "prefix+f"
#   type = "shell"
#   command = "~/.config/herdr/herdr-claude-branch.sh"
set -euo pipefail

# Extract the first "field":"value" string from a JSON blob on stdin.
json_field() { grep -oE "\"$1\":\"[^\"]*\"" | head -1 | cut -d'"' -f4; }

pane=$(herdr pane current)

# Pull the session ID from the agent_session object specifically (not any stray
# "value" key elsewhere in the payload), then cwd from the whole blob.
sid=$(printf '%s' "$pane" | grep -oE '"agent_session":\{[^}]*\}' | json_field value)
cwd=$(printf '%s' "$pane" | json_field cwd)
src_tab=$(printf '%s' "$pane" | json_field tab_id)

if [ -z "$sid" ]; then
  # Match the toast convention used by herdr-lazygit.sh / herdr-hunk.sh.
  herdr notification show "claude branch" --body "No Claude session in focused pane" --sound none
  exit 1
fi

# Source tab's display name, so we can name the branch after it.
src_label=$(herdr tab get "$src_tab" | json_field label)

# Create the focused tab and capture both the root pane (to run claude in) and
# the tab id (to rename). tab create returns the new tab's root_pane first, so
# the first pane_id and tab_id in the payload both belong to the new tab.
created=$(herdr tab create --focus ${cwd:+--cwd "$cwd"})
new_pane=$(printf '%s' "$created" | json_field pane_id)
new_tab=$(printf '%s' "$created" | json_field tab_id)
[ -n "$new_pane" ] || { echo "herdr-claude-branch: tab create failed" >&2; exit 1; }

# Name the branch tab after the source, suffixed with "-fork".
[ -n "$src_label" ] && herdr tab rename "$new_tab" "${src_label}-fork"

herdr pane run "$new_pane" "claude --resume '$sid' --fork-session"
